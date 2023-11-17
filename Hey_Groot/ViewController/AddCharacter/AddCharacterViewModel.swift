//
//  AddCharacterViewModel.swift
//  Hey_Groot
//
//  Created by 서명주 on 11/16/23.
//

import Foundation
import RxSwift
import RxCocoa
class AddCharacterViewModel{
    let items:Signal<[CharacterInfo]>
    let getItems = BehaviorRelay<[CharacterInfo]>(value: [])


    init(){
        items = getItems
            .asSignal(onErrorSignalWith: .empty())
    }
}
