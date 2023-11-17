//
//  SetCharacterViewModel.swift
//  Hey_Groot
//
//  Created by 서명주 on 11/16/23.
//

import Foundation
import RxSwift
import RxCocoa
class SetCharacterViewModel{
    let items:Signal<[MyRegisterPlant]>
    let getItems = BehaviorRelay<[MyRegisterPlant]>(value: [])


    init(){
        items = getItems
            .asSignal(onErrorSignalWith: .empty())

        
    }
}
