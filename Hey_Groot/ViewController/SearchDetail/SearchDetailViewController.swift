import Foundation
import UIKit
import RxSwift
import RxGesture
import Alamofire
import SnapKit

class SearchDetailViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let searchDetailView = SearchDetailView()
    let viewModel = SearchDetailViewModel()
    
    var item = [String]()
    var index:IndexPath?
    var viewController:SearchViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel)
        layout()
        attribute()
    }
    
    func layout() {
        view.addSubview(searchDetailView)
        searchDetailView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
       // addPlantRegistrationButton()
    }
    
    func bind(_ viewModel: SearchDetailViewModel) {
        searchDetailView.bind(viewModel)
        
        searchDetailView.tableView.rx.panGesture()
            .bind(with: self) { ss, gesture in
                let isDown = gesture.translation(in: ss.searchDetailView.tableView).y < 0
                
                UIView.animate(withDuration: 0.5) {
                    if isDown {
                        ss.searchDetailView.topConstraint?.isActive = true
                        ss.searchDetailView.baseConstraint?.isActive = false
                    } else {
                        ss.searchDetailView.topConstraint?.isActive = false
                        ss.searchDetailView.baseConstraint?.isActive = true
                    }
                    ss.view.layoutIfNeeded()
                }
            }
            .disposed(by: disposeBag)
        
        searchDetailView.bookMark.rx.tap
            .asObservable()
            .map { _ -> ApiRequest in
                var params = [String:Any]()
                params["plant_id"] = viewModel.getItems.value[0]
                let url = "http://3.20.48.164:8000/plant/mark/"
                let header = HTTPHeader(name: "Authorization", value: "Bearer \(Auth.token.accessToken)")
                return ApiRequest(params: params, url: url, header: header)
            }.flatMap { api -> Observable<ResponseMessage> in
                return getRequest(api, .post)
            }.bind { [weak self] data in
                guard let self = self else { return }
                print(data)
                self.searchDetailView.bookMark.isSelected = !(self.searchDetailView.bookMark.isSelected)
            }
            .disposed(by: disposeBag)
        
        searchDetailView.plantRegister_Button.rx.tap
            .asObservable()
            .bind { [weak self] data in
                guard let self = self else { return }
                self.dismiss(animated: true){
                    self.viewController?.dismissController(self.index!)
                }
            }
            .disposed(by: disposeBag)
            
    }
    
    func attribute() {
        self.view.backgroundColor = .white
        getBookMarklist()
        if viewController == nil{
            searchDetailView.plantRegister_Button.isHidden = true
        }
    }
    
    func getBookMarklist() {
        Observable.just("http://3.20.48.164:8000/plant/mark/list/")
            .map { url -> ApiRequest in
                var params = [String:Any]()
                let header = HTTPHeader(name: "Authorization", value: "Bearer \(Auth.token.accessToken)")
                return ApiRequest(params: params, url: url,header: header)
            }.flatMap{ api -> Observable<[BookMarkPlant_Info]> in
                return getRequest(api)
            }.bind{[weak self] data in
                guard let self = self else { return }
                self.searchDetailView.bookMark.isSelected = data.contains(where: {($0.plantinfo?.id ?? 0) == Int(self.viewModel.getItems.value[0])})
            }.disposed(by: disposeBag)
    }
    
   
}
extension Reactive where Base:SearchDetailViewController{
    
    
}
