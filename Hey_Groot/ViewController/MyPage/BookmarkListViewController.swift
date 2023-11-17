import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Alamofire

class BookmarkListViewController: UIViewController {
    let disposeBag = DisposeBag()
    let bookmarkListView = MyPageView()
    let viewModel = MyPageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        layout()
        attribute()
    }

    // MARK: - View Model Binding

    func bindViewModel() {
        bookmarkListView.bind(viewModel)

        bookmarkListView.tableView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let cell = self.bookmarkListView.tableView.cellForRow(at: indexPath) as? MyPageTableViewCell ?? MyPageTableViewCell()

                // Move to SearchDetailViewController and pass data
                let viewController = SearchDetailViewController()
                viewController.viewModel.getItems.accept(cell.item)
                viewController.viewModel.titlegetItems.accept(self.viewModel.titlegetItems.value)
                self.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
    }

    // MARK: - View Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchBookmarkList()
    }

    // MARK: - Layout

    func layout() {
        view.addSubview(bookmarkListView)
        bookmarkListView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
        }
    }

    // MARK: - Attribute

    func attribute() {
        view.backgroundColor = .white
        loadLocationsFromCSV()
    }

    // MARK: - Bookmark List Fetching

    private func fetchBookmarkList() {
        let url = "http://3.20.48.164:8000/plant/mark/list/"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Auth.token.accessToken)"]

        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: [BookMarkPlant_Info].self) { [weak self] response in
                guard let self = self else { return }

                switch response.result {
                case .success(let data):
                    self.viewModel.bookMarkGetItems.accept(data)
                case .failure(let error):
                    print("Error fetching bookmarks: \(error)")
                    // Handle the error, show an alert, or perform other error-related tasks
                }
            }
    }

    // MARK: - CSV Parsing and Loading

    private func parseCSVAt(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)

            guard let dataArr = dataEncoded?.components(separatedBy: "\n").map({ $0.components(separatedBy: ",") }) else {
                print("Error parsing CSV data.")
                return
            }

            viewModel.titlegetItems.accept(dataArr.first ?? [])
            viewModel.getItems.accept(dataArr.dropFirst().dropLast().map { $0 })
            viewModel.getoriginItems.accept(dataArr.dropFirst().dropLast().map { $0 })
        } catch {
            print("Error reading CSV file: \(error)")
        }
    }

    private func loadLocationsFromCSV() {
        guard let path = Bundle.main.path(forResource: "plant_info", ofType: "csv") else {
            print("CSV file not found.")
            return
        }

        parseCSVAt(url: URL(fileURLWithPath: path))
        bookmarkListView.tableView.reloadData()
    }
}
