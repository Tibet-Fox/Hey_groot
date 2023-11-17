//
//  AddCharacterView.swift
//  Hey_Groot
//
//  Created by 서명주 on 11/16/23.
//

import Foundation
import UIKit

import SnapKit
import RxSwift
class AddCharacterView:UIView{
    
    let disposeBag = DisposeBag()
    
    let backView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let title_Label:UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        label.text = "캐릭터 선택"
        return label
    }()
    
    let collectionView:UICollectionView = {
            let layout = UICollectionViewFlowLayout()
           // layout.minimumInteritemSpacing = .zero
            //layout.sectionInset = .zero
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layout.scrollDirection = .horizontal
            //layout.minimumLineSpacing = .zero
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.isPagingEnabled = true
            cv.showsHorizontalScrollIndicator  = false
            cv.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.1764705882, blue: 0.4196078431, alpha: 0)
            cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            //cv.isPagingEnabled = true
            return cv
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout(){
        [backView].forEach{
            self.addSubview($0)
        }
        
        [title_Label,collectionView].forEach{
            backView.addSubview($0)
        }
        
        backView.snp.makeConstraints{
            $0.bottom.equalTo(self.snp.bottom)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.height.equalTo(250)
        }
        
        title_Label.snp.makeConstraints{
            $0.top.equalTo(backView.snp.top).offset(20)
            $0.centerX.equalTo(backView.snp.centerX)
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(title_Label.snp.bottom).offset(10)
            $0.height.equalTo(150)
            $0.centerX.equalTo(backView.snp.centerX)
            $0.leading.equalTo(backView.snp.leading)
            $0.trailing.equalTo(backView.snp.trailing)
            
        }
    }
    
    func bind(_ viewModel:AddCharacterViewModel){
        viewModel.getItems
            .asObservable()
            .bind(to: collectionView.rx.items){ cv, row, data in
                guard let cell = cv.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: IndexPath(row: row, section: 0)) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
                cell.setItem(data)
                return cell
            }.disposed(by: disposeBag)
    }
    
    func attribute(){
        collectionView.register(CharacterCollectionViewCell.self
                                , forCellWithReuseIdentifier: "CharacterCollectionViewCell")
        
    }
}
