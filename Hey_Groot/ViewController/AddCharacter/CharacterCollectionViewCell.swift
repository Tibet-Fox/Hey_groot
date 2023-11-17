//
//  CharacterCollectionViewCell.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/09/09.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher
class CharacterCollectionViewCell: UICollectionViewCell{
    
    let imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func layout(){
        [imageView].forEach{
            self.contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints{
            $0.top.equalTo(self.contentView.snp.top)
            $0.leading.equalTo(self.contentView.snp.leading).offset(15)
            $0.trailing.equalTo(self.contentView.snp.trailing).inset(15)
            $0.bottom.equalTo(self.contentView.snp.bottom)
            $0.width.equalTo(70)
            $0.height.equalTo(391 * 70 / 234)
        }
    }
    
    
    func setItem(_ item:CharacterInfo){
        imageView.kf.setImage(with: URL(string: item.basic_emo ?? ""))
    }
}
