import Foundation
import Alamofire
import SnapKit
import UIKit
import RxSwift
class SetCharacterController: UIViewController {
    
    let disposeBag = DisposeBag()
    let setCharacterView = SetCharacterView()
    let viewModel = SetCharacterViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel)
        layout()
        attribute()
        
    }
    
    
    func layout(){
        [setCharacterView].forEach{
            self.view.addSubview($0)
        }
        
        setCharacterView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func attribute(){
        // 배경색을 흰색으로 설정하고 투명도를 조절
        view.backgroundColor = UIColor.white.withAlphaComponent(1) // 투명도를 1로 설정
        
       
        // 네비게이션 바 타이틀 설정
        self.title = "등록한 내 식물"
        
        // 네비게이션 바의 왼쪽에 "Back" 버튼 추가 (이전 화면으로 돌아가기)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        
        // 네비게이션 바의 왼쪽에 "sensor" 문구와 화살표 아이콘을 함께 표시
        let mypageItem = UIBarButtonItem(title: "Mypage", style: .plain, target: nil, action: nil)
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        // 이미지와 타이틀 간 여백 조절
        mypageItem.imageInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: -10)
        
        // 두 개의 UIBarButtonItem을 UIStackView로 묶어서 표시
        let combinedItems = [backButton, mypageItem]
        self.navigationItem.leftBarButtonItems = combinedItems
    }
    
    func bind(_ viewModel:SetCharacterViewModel){
        setCharacterView.bind(viewModel)
        Observable.just("http://3.20.48.164:8000/plant/partner/")
            .map { url -> ApiRequest in
                var params = [String:Any]()
                let header = HTTPHeader(name: "Authorization", value: "Bearer \(Auth.token.accessToken)")
                return ApiRequest(params: params, url: url, header: header)
            }.flatMap { api -> Observable<[MyRegisterPlant]> in
                return getRequest(api,.get)
            }.bind {data in
                viewModel.getItems.accept(data)
            }
            .disposed(by: disposeBag)
    }
    
   
    
    @objc func backButtonTapped() {
        // "Back" 버튼이 탭되었을 때 수행할 동작을 여기에 추가
        print("Back 버튼이 탭되었습니다.")
        // 화면을 닫고 이전 화면으로 돌아가기
        self.dismiss(animated: true, completion: nil)
    }
    
}
