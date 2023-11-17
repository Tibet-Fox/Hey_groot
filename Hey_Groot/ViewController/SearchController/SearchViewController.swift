//
//  HomeViewController.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/09/03.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchViewController: UIViewController{
    
    let disposeBag = DisposeBag()
    
    let viewModel = SearchViewModel()
    let searchView = SearchView()
    
    var viewController:AddPlantViewController?
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 0.988, green: 0.98, blue: 0.945, alpha: 1)
        bind(viewModel)
        layout()
        attribute()
        
    }
    
    func bind(_ viewModel:SearchViewModel){
        searchView.bind(viewModel)
        
        searchView.search_TextField
            .rx
            .text.changed
            .asObservable()
            .subscribe { string in
                if string.element!!.elementsEqual(""){
                    viewModel.getItems.accept(viewModel.getoriginItems.value)
                }else{
                    var arr = [[String]]()
                    viewModel.getoriginItems.value.forEach{
                        if $0.count > 3{
                            if $0[2].contains((string.element ?? "") ?? ""){
                                arr.append($0)
                            }
                        }
                        
                        
                    }
                    viewModel.getItems.accept(arr)
                }
               
                
            }.disposed(by: disposeBag)
        
        
        searchView.tableView
            .rx
            .itemSelected
            .bind(to: self.rx.selectTeableView)
            .disposed(by: disposeBag)
    }
    
    func layout(){
        [searchView].forEach{
            self.view.addSubview($0)
        }
        
        searchView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func attribute(){
        self.view.backgroundColor = .white
        loadLocationsFromCSV()
    }
    
    private func parseCSVAt(url:URL) {
           do {
               
               let data = try Data(contentsOf: url)
               let dataEncoded = String(data: data, encoding: .utf8)
               
               if var dataArr = dataEncoded?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}) {
                   viewModel.titlegetItems.accept(dataArr.remove(at: 0))
                   dataArr.remove(at: dataArr.count - 1)
                   
                   var value = [[String]]()
                   for item in dataArr {
                           value.append(item)
                   }
                   viewModel.getItems.accept(value)
                   viewModel.getoriginItems.accept(value)
               }
               
           } catch  {
               print("Error reading CSV file")
           }
       }

    private func loadLocationsFromCSV() {
        let path = Bundle.main.path(forResource: "plant_info", ofType: "csv")!
        parseCSVAt(url: URL(fileURLWithPath: path))
        searchView.tableView.reloadData()
    }
    
    func dismissController(_ index:IndexPath){
        self.dismiss(animated: true){
            self.viewController?.setPlantInfo(self.viewModel.getItems.value[index.row])
        }
        
    }
}

extension Reactive where Base:SearchViewController{
    
    var selectTeableView:Binder<ControlEvent<IndexPath>.Element>{
        return Binder(base){ base, index in
            
                let viewController = SearchDetailViewController()
            if base.viewController != nil{
                viewController.viewController = base
                viewController.index = index
            }
                let navController = UINavigationController(rootViewController:  viewController) // 내비게이션 컨트롤러 생성
                base.present(navController, animated: true, completion: nil) // 화면 전환
                viewController.viewModel.getItems.accept(base.viewModel.getItems.value[index.row])
                viewController.viewModel.titlegetItems.accept(base.viewModel.titlegetItems.value)
            
        }
    }
    
}
