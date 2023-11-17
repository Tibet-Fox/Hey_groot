//
//  SensorViewController.swift
//  Hey_Groot
//
//  Created by 김경민 on 10/26/23.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import Alamofire

class SensorViewController: UIViewController{
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]  // Set title color
        
        // 스택 뷰 생성
        let stackView = UIStackView()
        stackView.axis = .vertical // 수직으로 배치
        stackView.distribution = .fillEqually // 뷰를 동일한 크기로 채우기
        stackView.spacing = 30 // 버튼 간격 조정
        
        // "Today is" 레이블 생성
        let todayLabel = UILabel()
        todayLabel.text = "Today is..."
        todayLabel.font = UIFont.systemFont(ofSize: 24) // 폰트 크기 설정
        todayLabel.textAlignment = .center // 가운데 정렬
        todayLabel.textColor = .black // 텍스트 색상 설정
        
        // 현재 날짜를 가져오기
        let currentDate = Date()

        // 날짜를 문자열로 포맷팅하기 위한 DateFormatter 설정
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd(EEE)" // 날짜 형식 지정

        // 현재 날짜를 포맷에 맞게 문자열로 변환하여 레이블에 설정
        todayLabel.text = "Today is \(dateFormatter.string(from: currentDate))"
        
        
        // "Today is" 레이블의 Auto Layout 설정
        view.addSubview(todayLabel)
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 레이블의 위치 지정: 화면 상단 중앙에 배치
        todayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        todayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        //        // "2023.10.27(금)" 레이블 생성
        //        let dateLabel = UILabel()
        //            dateLabel.text = "2023.10.27(금)"
        //            dateLabel.font = UIFont.systemFont(ofSize: 18)
        //            dateLabel.textAlignment = .center
        //            dateLabel.textColor = .black
        //
        
        
        // 레이블을 스택 뷰에 추가
        stackView.addArrangedSubview(todayLabel)
        //            stackView.addArrangedSubview(dateLabel)
        
        //버튼 배열
//        var buttons: [UIButton] = []
        
        for column in 0..<2 {
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal // 수평으로 배치
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.spacing = 30

            for row in 0..<2 {
                let button = UIButton(type: .system)
                // ... (이미지 및 색상 설정)

                // 버튼에 개별적인 타이틀 및 시스템 이미지 설정
                let tag = column * 2 + row
                if tag == 0 {
                    button.setTitle("Temperature", for: .normal)
                    button.setImage(UIImage(systemName: "thermometer")?.withTintColor(.white), for: .normal)
                } else if tag == 1 {
                    button.setTitle("Humidity", for: .normal)
                    button.setImage(UIImage(systemName: "drop.fill")?.withTintColor(.white), for: .normal)
                } else if tag == 2 {
                    button.setTitle("Luminosity", for: .normal)
                    button.setImage(UIImage(systemName: "lightbulb.fill")?.withTintColor(.white), for: .normal)
                } else if tag == 3 {
                    button.setTitle("Monitoring", for: .normal)
                    button.setImage(UIImage(systemName: "eye")?.withTintColor(.white), for: .normal)
                }

                // 버튼에 고유한 tag 값을 부여
                button.tag = tag
                
                //버튼색상
                button.layer.backgroundColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1).cgColor
                button.setTitleColor(.white, for: .normal)
                button.layer.cornerRadius = 8 // 버튼 둥글게 처리
                button.titleLabel?.font = UIFont.systemFont(ofSize: 18) // 버튼 텍스트 폰트 크기
                
                // Auto Layout을 사용하여 버튼 크기 및 위치 조정
                button.translatesAutoresizingMaskIntoConstraints = false
                button.widthAnchor.constraint(equalToConstant: 150).isActive = true // 버튼의 너비 설정
                button.heightAnchor.constraint(equalToConstant: 150).isActive = true // 버튼의 높이
                
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                horizontalStackView.addArrangedSubview(button)
            }
            
            stackView.addArrangedSubview(horizontalStackView)
        }
        
        // 스택 뷰를 루트 뷰에 추가
        view.addSubview(stackView)
        
        // 스택 뷰의 레이아웃 설정
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

                
                // 버튼에 액션(동작)을 추가할 수 있음
                
                @objc func buttonTapped(_ sender: UIButton) {
                    // 버튼이 탭되었을 때 수행할 동작을 여기에 추가
                    
                    if let title = sender.title(for: .normal) {
                        print("\(title) 버튼이 탭되었습니다.")
                        
                        // 버튼 태그를 기반으로 화면 전환 처리
                        switch sender.tag {
                        case 0:
                            navigateToTemperatureViewController()
                            //"temperature" 버튼을 눌렀을 때 전환
                            
                        case 1:
                            navigateToHumidityViewController() // "Humidity" 버튼을 눌렀을 때 전환
                        case 2:
                            navigateToLuminosityViewController()
                            //"Luminosity" 버튼 눌렀을 때 전환
                            
                        case 3:
                            navigateToMonitoringViewController() //"Monitoring" 버튼 눌렀을 때 전환
                            
                        default:
                            break
                            
                            
                        }
            
        }
    }
    private func navigateToTemperatureViewController() {
        let temperatureVC = TemperatureViewController() // SetInfoViewController의 인스턴스 생성
        let navController = UINavigationController(rootViewController: temperatureVC) // 내비게이션 컨트롤러 생성
        self.present(navController, animated: true, completion: nil) // 화면 전환
    }
    
    private func navigateToHumidityViewController() {
        let humidityVC = HumidityViewController() // BookmarkListViewController의 인스턴스 생성
        let navController = UINavigationController(rootViewController: humidityVC) // 내비게이션 컨트롤러 생성
        self.present(navController, animated: true, completion: nil) // 화면 전환
    }
    
    private func navigateToLuminosityViewController() {
        let luminosityVC = LuminosityViewController() //
        let navController = UINavigationController(rootViewController: luminosityVC) // 내비게이션 컨트롤러 생성
        self.present(navController, animated: true, completion: nil) // 화면 전환
    }
    
    private func navigateToMonitoringViewController() {
        let monitoringVC = MonitoringViewController() //
        let navController = UINavigationController(rootViewController: monitoringVC) // 내비게이션 컨트롤러 생성
        self.present(navController, animated: true, completion: nil) // 화면 전환
    }
    
}

