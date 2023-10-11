// 현재까지 최종 코드
import Foundation
import UIKit

class MyPageViewController: UIViewController{
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "마이페이지"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]  // Set title color
        
        
        let buttonTitles1 = ["회원정보 수정", "알림", "북마크리스트", "캐릭터수정하기", "앱버전","로그아웃","탈퇴하기"]
        
        // 버튼을 생성하고 설정
        for i in 0..<7 {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitles1[i], for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.tag = i //버튼에 태그를 부여하여 어떤 버튼이 클릭되었는지 확인
            button.frame = CGRect(x: 15, y: 250 + i * 60, width: 358, height: 50)
            
            //스위치 버튼 생성
            let notificationSwitch = UISwitch()
            notificationSwitch.addTarget(self, action: #selector(notificationSwitchValueChanged(_:)), for: .valueChanged)
            notificationSwitch.frame = CGRect(x: 280, y: 250 + 1.15 * 60 , width: 50, height: 30) // 필요에 따라 프레임 조정

            self.view.addSubview(notificationSwitch)

            
            
            
            //버튼 공통설정
            //버튼 테두리, 폰트 설정
            button.layer.cornerRadius = 12
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            // 버튼의 배경색 설정
            button.layer.backgroundColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1).cgColor
          
            
            // 버튼의 텍스트 색상 설정
            button.setTitleColor(UIColor.white, for: .normal)
            
            
            switch i {
                
            case 1:
                let notificationButton = UIButton(type: .system)
                notificationButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                notificationButton.frame = CGRect(x: 15 + 50 + 10, y: 250 + 1 * 60, width: 358 - 50 - 10, height: 50) // Adjust frame as needed
           
            case 5:
                //로그아웃 버튼
                button.backgroundColor = UIColor.white
                button.setTitleColor(UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1), for: .normal)
                //버튼 테두리 굵기와 색상 설정
                button.layer.borderWidth = 2.0
                button.layer.borderColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1).cgColor
                button.frame = CGRect(x: 15, y: 620, width: 358, height: 50)
                
                
            case 6:
                //탈퇴하기 버튼
                button.backgroundColor = UIColor.white
                button.setTitleColor(UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1), for: .normal)
                //버튼 테두리 굵기와 색상 설정
                button.layer.borderWidth = 2.0
                button.layer.borderColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1).cgColor
                button.frame = CGRect(x: 15, y: 680, width: 358, height: 50)
                default:
                   break
            }
         
            
            // 버튼에 이미지 설정 (옵셔널)
            // button.setImage(UIImage(named: "buttonImage"), for: .normal)
            
            self.view.addSubview(button)
        }
            }
    
    
    @objc func buttonTapped(_ sender: UIButton) {
        // 버튼이 탭되었을 때 수행할 동작을 여기에 추가
        
        if let title = sender.title(for: .normal) {
            print("\(title) 버튼이 탭되었습니다.")
            
            // 버튼 태그를 기반으로 화면 전환 처리
            switch sender.tag {
            case 0:
                navigateToSetInfoViewController()
                //"회원정보 수정" 버튼을 눌렀을 때 전환
            
            case 2:
                navigateToBookmarkListViewController() // "북마크 리스트" 버튼을 눌렀을 때 전환
            case 3:
                navigateToSetCharacterViewController()
                //"캐릭터 수정하기" 버튼 눌렀을 때 전환
                
            case 4:
                navigateToAppVersionViewController() //"앱버전" 버튼 눌렀을 때 전환
                
//            case 5:
//                presentLoginViewController() //"로그아웃" 버튼 눌렀을 때 전환
            default:
                break
                
                
            }
            
            
            
        }
        
    }
    
   
    
    @objc private func notificationSwitchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            print("알림 스위치가 켜졌습니다.")
            // Handle switch being turned on
        } else {
            print("알림 스위치가 꺼졌습니다.")
            // Handle switch being turned off
        }
        
    }
    
    private func navigateToSetInfoViewController() {
        let setInfoVC = SetInfoViewController() // SetInfoViewController의 인스턴스 생성
        let navController = UINavigationController(rootViewController: setInfoVC) // 내비게이션 컨트롤러 생성
        self.present(navController, animated: true, completion: nil) // 화면 전환
    }
    
    private func navigateToBookmarkListViewController() {
        let bookmarkListVC = BookmarkListViewController() // BookmarkListViewController의 인스턴스 생성
        let navController = UINavigationController(rootViewController: bookmarkListVC) // 내비게이션 컨트롤러 생성
        self.present(navController, animated: true, completion: nil) // 화면 전환
    }
    
    private func navigateToSetCharacterViewController() {
        let setCharacterVC = SetCharacterController() //
        let navController = UINavigationController(rootViewController: setCharacterVC) // 내비게이션 컨트롤러 생성
        self.present(navController, animated: true, completion: nil) // 화면 전환
    }
    
    private func navigateToAppVersionViewController() {
        let appVersionVC = AppVersionViewController() //
        let navController = UINavigationController(rootViewController: appVersionVC) // 내비게이션 컨트롤러 생성
        self.present(navController, animated: true, completion: nil) // 화면 전환
    }
    
    //로그아웃 버튼을 클릭했을 때 loginViewController로 이동시키려고 생성.
//    private func presentLoginViewController() {
//        let loginViewController = LoginViewController() // Instantiate your LoginViewController
//        loginViewController.modalPresentationStyle = .fullScreen // Set the presentation style
//
//        // Present the LoginViewController
//        present(loginViewController, animated: true, completion: nil)
//
//    }
    
}

