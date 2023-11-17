//
//  AddCharacterViewController.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/09/09.
//

import Foundation
import UIKit
import PanModal
import SnapKit
import RxSwift
import Alamofire
class AddCharacterViewController : UIViewController{
    

    let disposeBag = DisposeBag()
    let addCharacterView = AddCharacterView()
    let viewModel = AddCharacterViewModel()
    
    var viewController:AddPlantViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind(viewModel)
        attribute()
    }
    
    func bind(_ viewModel:AddCharacterViewModel){
        addCharacterView.bind(viewModel)
        
        Observable.just("http://3.20.48.164:8000/plant/characters")
            .map { url -> ApiRequest in
                var params = [String:Any]()
                let header = HTTPHeader(name: "Authorization", value: "Bearer \(Auth.token.accessToken)")
                return ApiRequest(params: params, url: url, header: header)
            }.flatMap { api -> Observable<[CharacterInfo]> in
                return getRequest(api)
            }.bind { data in
                viewModel.getItems.accept(data)
            }
            .disposed(by: disposeBag)
        
        addCharacterView.collectionView.rx.itemSelected
            .asObservable()
            .bind(to: self.rx.selectCollectionItem)
            .disposed(by: disposeBag)
    }
    
    func layout(){
        [addCharacterView].forEach{
            self.view.addSubview($0)
        }
        
        addCharacterView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(self.view.snp.bottom)
        }
    }
    
    func attribute(){
        
    }
}

extension Reactive where Base:AddCharacterViewController{
    
    var selectCollectionItem:Binder<IndexPath>{
        return Binder(base){ base, index in
            base.viewController?.characterInfo = base.viewModel.getItems.value[index.row]
            base.dismiss(animated: true)
        }
    }
    
}
