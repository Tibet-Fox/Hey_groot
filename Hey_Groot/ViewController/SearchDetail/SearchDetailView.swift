

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import Kingfisher
import UIKit

class SearchDetailView : UIView{
    
    let disposeBag = DisposeBag()
    var topConstraint:Constraint?
    var baseConstraint:Constraint?
    
    let imageView:UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let backView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.shadowOpacity = 0.16
        
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.backgroundColor = .white
        return view
    }()
    
    let titleView:UIView = {
        let view = UIView()
        return view
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let bookMark:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bookmark"), for: .normal)
        button.setImage(UIImage(named: "bookmark_on"), for: .selected)
        return button
    }()
    
    let plantRegister_Button:UIButton = {
        let button = UIButton()
        if let font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15) as UIFont? {
            let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
            let attributedTitle = NSAttributedString(string: "내 식물 등록하기", attributes: attributes)
            button.setAttributedTitle(attributedTitle, for: .normal)
        } else {
            print("폰트를 로드하지 못했습니다.")
        }
        button.backgroundColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1)
        button.layer.cornerRadius = 12
        button.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SearchDetailViewModel){
        
        imageView.kf.setImage(
            with: URL(string: viewModel.getItems.value[3]) ,
          placeholder: nil,
          options: nil,
          completionHandler: nil
        )
        
        titleLabel.text = viewModel.getItems.value[2]
        
        viewModel.items
            .asObservable()
            .bind(to: tableView.rx.items){ tv, row, data in
                guard let cell = tv.dequeueReusableCell(withIdentifier: "SearchDetailTableViewCell", for: IndexPath(row: row, section: 0)) as? SearchDetailTableViewCell else { return UITableViewCell() }
                cell.setData(data,row,viewModel)
                return cell
            }.disposed(by: disposeBag)
    }
    
    func layout(){
        [imageView,backView,plantRegister_Button].forEach{
            self.addSubview($0)
        }
        
        [titleLabel,tableView,bookMark].forEach{
            backView.addSubview($0)
        }
        
        imageView.snp.makeConstraints{
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            
            let width = UIScreen.main.bounds.width
            let height = 1038 * width / 956
            $0.height.equalTo(height)
        }
        backView.snp.makeConstraints{
            baseConstraint = $0.top.equalTo(imageView.snp.bottom).offset(-40).constraint
            topConstraint = $0.top.equalTo(self.snp.top).constraint
            topConstraint?.isActive = false
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
        bookMark.snp.makeConstraints{
            $0.top.equalTo(backView.snp.top).offset(20)
            $0.trailing.equalTo(backView.snp.trailing).inset(20)
            $0.height.width.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(backView.snp.top).offset(20)
            $0.leading.equalTo(backView.snp.leading).offset(20)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(self.backView.snp.leading)
            $0.trailing.equalTo(self.backView.snp.trailing)
            $0.bottom.equalTo(self.backView.snp.bottom)
        }
        
        plantRegister_Button.snp.makeConstraints{
            $0.width.equalTo(119)
            $0.height.equalTo(30)
            $0.centerX.equalTo(self.snp.centerX)
            $0.bottom.equalTo(self.snp.bottom).inset(20)
        }
    }
    
    func attribute(){
        backgroundColor = .white
        tableView.register(SearchDetailTableViewCell.self, forCellReuseIdentifier: "SearchDetailTableViewCell")
    }
}

