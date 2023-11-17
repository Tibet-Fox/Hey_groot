

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
class SetCharacterView:UIView{
    
    let disposeBag = DisposeBag()
    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel:SetCharacterViewModel){
        viewModel.items
            .asObservable()
            .bind(to: tableView.rx.items){ tv, row, data in
                guard let cell = tv.dequeueReusableCell(withIdentifier: "SetCharacterTableCell", for: IndexPath(row: row, section: 0)) as? SetCharacterTableCell else { return UITableViewCell() }
                cell.setData(data)
                return cell
            }.disposed(by: disposeBag)
    }
    
    func layout(){
        [tableView].forEach{
            self.addSubview($0)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func attribute(){
        tableView.register(SetCharacterTableCell.self, forCellReuseIdentifier: "SetCharacterTableCell")
    }
}
