//
//  File.swift
//  Hey_Groot
//
//  Created by 서명주 on 2023/09/07.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class SetCharacterTableCell:UITableViewCell{
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setData(_ item:MyRegisterPlant){
        titleLabel.text = item.name
    }
    
    
    func layout(){
        [titleLabel].forEach{
            self.contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(self.contentView.snp.top)
            $0.leading.equalTo(self.contentView.snp.leading).offset(20)
            $0.trailing.equalTo(self.contentView.snp.trailing)
            $0.bottom.equalTo(self.contentView.snp.bottom)
            $0.height.equalTo(50)
        }
    }
}
