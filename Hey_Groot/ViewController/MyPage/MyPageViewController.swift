import Foundation
import UIKit
import SnapKit
import RxSwift
import Alamofire

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

class MyPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // 섹션과 각 섹션의 행 수를 정의합니다.
    let sections = ["", "", ""]
    let section1Data = ["스킨"]
    let section2Data = ["알림", "북마크 리스트", "등록한 내식물", "앱 버전"]
    let section3Data = ["로그아웃", "탈퇴하기"]
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // 테이블 뷰 초기화 및 설정
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        //        // 네비게이션 컨트롤러를 루트 뷰 컨트롤러로 설정합니다.
        // self.view = navigationController.view
        // addChild(navigationController)
        
        // 배경색 변경
        view.backgroundColor = UIColor(red: 0.467, green: 0.420, blue: 0.365, alpha: 1.0) // RGB 값으로 배경색 설정
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return section1Data.count
        } else if section == 1 {
            return section2Data.count
        } else {
            return section3Data.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            // "이미지와 레이블" 셀의 높이를 설정
            return 80.0 // 원하는 높이로 설정
        } else {
            // 다른 섹션 및 셀의 경우 기본 높이 반환
            return UITableView.automaticDimension
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

           if indexPath.section == 0 {
               // 섹션 1
               if let text = section1Data.first {
                    let attributedString = NSMutableAttributedString(string: text)
                           attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: NSRange(location: 0, length: text.count))
                           cell.textLabel?.attributedText = attributedString
                       }

                       cell.accessoryType = .disclosureIndicator // 오른쪽에 화살표 아이콘 삽입

               if indexPath.row == 0 {
                   // "이미지와 레이블" 셀의 이미지 설정
                   if let image = UIImage(named: "Character1") {
                       let imageSize = CGSize(width: 60, height: 60) // 이미지 크기 조정
                       let scaledImage = image.resized(to: imageSize)
                       let imageView = UIImageView(image: scaledImage)
                       cell.imageView?.image = imageView.image
                   }
               }
            
            
        } else if indexPath.section == 1 {
            cell.textLabel?.text = section2Data[indexPath.row]

            switch indexPath.row {
            case 0:
                // 스위치 셀을 생성하고 설정
                let switchView = UISwitch()
                switchView.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
                cell.accessoryView = switchView
                
                
            case 1:
                // "북마크 리스트"가 선택되었을 때 BookmarkListViewController로 이동
                cell.accessoryType = .disclosureIndicator // 오른쪽에 화살표 아이콘 삽입
            case 2:
                // "등록한 내식물"이 선택되었을 때 MyPlantViewController로 이동
                cell.accessoryType = .disclosureIndicator // 오른쪽에 화살표 아이콘 삽입
            case 3:
                // "앱 버전"이 선택되었을 때 AppVersionViewController로 이동
                cell.accessoryType = .disclosureIndicator // 오른쪽에 화살표 아이콘 삽입
            default:
                break
            }
        } else {
            cell.textLabel?.text = section3Data[indexPath.row]
            cell.accessoryType = .disclosureIndicator // 오른쪽에 화살표 아이콘 삽입
        }

        // 셀의 배경색을 지정
        cell.backgroundColor = UIColor.white
        // 셀의 contentView의 테두리를 둥글게 만듭니다.
        cell.contentView.layer.cornerRadius = 30
        cell.contentView.layer.masksToBounds = true
        return cell
    }

    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            // 섹션 0에 레이블을 추가하여 "마이페이지" 표시
            let label = UILabel()
            label.text = "마이페이지"
            label.textColor = UIColor.black
            // label.backgroundColor = UIColor.lightGray
            label.font = UIFont.boldSystemFont(ofSize: 20) // 굵기와 크기 설정
            label.textAlignment = .center // 가운데 정렬
            label.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40) // 위치와 높이 설정
            return label
        }
        return nil // 다른 섹션에는 헤더 뷰를 추가하지 않음
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            // 섹션 0의 헤더 높이를 설정하여 섹션 0과 섹션 1 사이의 여백을 추가
            return 60 // 원하는 여백 크기로 설정
        } else if section == 1 {
            // 섹션 1의 헤더 높이를 설정하여 섹션 1과 섹션 2 사이의 여백을 추가
            return 60 // 원하는 여백 크기로 설정
        } else if section == 2 {
            // 섹션 2의 헤더 높이를 설정하여 섹션 2와 섹션 3 사이의 여백을 추가
            return 60 // 원하는 여백 크기로 설정
        }
        return 0.001 // 다른 섹션의 헤더 높이를 0으로 설정하여 숨김
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                // "이미지와 레이블"이 선택되었을 때 SetInfoViewController로 전환
                navigateToSetInfoViewController()
            }
        case 1:
            switch indexPath.row {
//            case 0:
                
            case 1:
                // "북마크 리스트"가 선택되었을 때 BookmarkListViewController로 이동
                navigateToBookmarkListViewController()
            case 2:
                // "등록한 내식물"이 선택되었을 때 MyPlantViewController로 이동
                navigateToMyPlantViewController()
            case 3:
                // "앱 버전"이 선택되었을 때 AppVersionViewController로 이동
                navigateToAppVersionViewController()
            default:
                break
            }
//        case 2:
//            switch indexPath.row {
//            case 0:
//                // "로그아웃"이 선택되었을 때 처리
//                // Add code to handle the selection (if needed)
//            case 1:
//                // "탈퇴하기"가 선택되었을 때 처리
//                // Add code to handle the selection (if needed)
//            default:
//                break
//            }
        default:
            break
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
    
    private func navigateToMyPlantViewController() {
        let myPlantVC = SetCharacterController() //
        let navController = UINavigationController(rootViewController: myPlantVC) // 내비게이션 컨트롤러 생성
        self.present(navController, animated: true, completion: nil) // 화면 전환
    }
    
    private func navigateToAppVersionViewController() {
        let appVersionVC = AppVersionViewController() //
        let navController = UINavigationController(rootViewController: appVersionVC) // 내비게이션 컨트롤러 생성
        self.present(navController, animated: true, completion: nil) // 화면 전환
    }
    @objc func switchChanged(_ sender: UISwitch) {
        // Handle the switch state change here
        if sender.isOn {
            print("Switch is ON")
        } else {
            print("Switch is OFF")
        }
    }

    
}
