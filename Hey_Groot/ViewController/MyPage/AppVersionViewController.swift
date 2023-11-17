import Foundation
import UIKit

class AppVersionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색을 흰색으로 설정하고 투명도를 조절
        view.backgroundColor = UIColor.white.withAlphaComponent(1) // 투명도를 1로 설정
        
       
        // 네비게이션 바 타이틀 설정
        self.title = "앱버전"
        
        // 네비게이션 바의 왼쪽에 "sensor" 문구와 화살표 아이콘을 함께 표시
                let mypageItem = UIBarButtonItem(title: "Mypage", style: .plain, target: nil, action: nil)
                
                let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
                
                // 이미지와 타이틀 간 여백 조절
                mypageItem.imageInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: -10)
                
                // 두 개의 UIBarButtonItem을 UIStackView로 묶어서 표시
                let combinedItems = [backButton, mypageItem]
                self.navigationItem.leftBarButtonItems = combinedItems
            
        //버전 정보를 표시할 레이블 생성
        let versionLabel = UILabel(frame: CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 30))
                versionLabel.text = "Version: 15.0"
                versionLabel.textAlignment = .center
                versionLabel.textColor = .black
        // 뷰에 레이블 추가
                view.addSubview(versionLabel)
       
    }
    
    
    @objc func backButtonTapped() {
        // "Back" 버튼이 탭되었을 때 수행할 동작을 여기에 추가
        print("Back 버튼이 탭되었습니다.")
        // 화면을 닫고 이전 화면으로 돌아가기
        self.dismiss(animated: true, completion: nil)
    }
}
