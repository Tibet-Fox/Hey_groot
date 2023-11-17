//
//  TemperatureViewController.swift
//  Hey_Groot
//
//  Created by 김경민 on 10/27/23.
//


import Foundation
import UIKit

//struct YourDataModel: Codable {
////    let partner: Partner
//       let datas: [SensorData]
//
//    struct SensorData: Codable {
//        let partner_id: Int
//        let date: String
//        let light: Double
//        let humid: Double
//        let temp: Double
//        let soil: Int
//    }
//}

class HumidityViewController: UIViewController {
    
    // 레이블을 생성
    let plantDataLabel = UILabel()
    // "센서값" 레이블 생성
       let sensorLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 배경색을 흰색으로 설정하고 투명도를 조절
        view.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        
        // 네비게이션 바 타이틀 설정
        self.title = "Humidity"
        
        // 네비게이션 바의 왼쪽에 "sensor" 문구와 화살표 아이콘을 함께 표시
        let sensorItem = UIBarButtonItem(title: "Sensor", style: .plain, target: nil, action: nil)
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        // 이미지와 타이틀 간 여백 조절
        sensorItem.imageInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: -10)
        
        // 두 개의 UIBarButtonItem을 UIStackView로 묶어서 표시
        let combinedItems = [backButton, sensorItem]
        self.navigationItem.leftBarButtonItems = combinedItems
        
        
      
        // "센서값" 레이블 추가
        view.addSubview(sensorLabel)
        sensorLabel.numberOfLines = 0 // 여러 줄의 텍스트 허용
        sensorLabel.lineBreakMode = .byWordWrapping // 단어 단위로 줄 바꿈
        sensorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sensorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sensorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            sensorLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8) // 예시로 너비를 화면 너비의 80%로 설정
        ])

        
        fetchDataFromServer()
        
    }
    
    // Function to parse JSON data and update UI
       func updateUI(with jsonData: Data) {
           do {
               let decoder = JSONDecoder()
               let jsonDataObject = try decoder.decode(YourDataModel.self, from: jsonData)

               // Assuming YourDataModel is a struct or class representing your JSON structure
               if let latestData = jsonDataObject.datas.last {
                   DispatchQueue.main.async {
                       // Update UI elements with the latest data
                          let boldAttributes: [NSAttributedString.Key: Any] = [
                              .font: UIFont.boldSystemFont(ofSize: 16) // 여기서 16은 굵은체 텍스트의 크기
                          ]
                          
                          let attributedText = NSMutableAttributedString(string: "Humidity: ", attributes: boldAttributes)
                          
                          // Append the non-bold part of the text
                          attributedText.append(NSAttributedString(string: "\(latestData.humid) %"))
                          
                          self.sensorLabel.attributedText = attributedText
                          self.view.addSubview(self.sensorLabel)
                          self.sensorLabel.translatesAutoresizingMaskIntoConstraints = false
                          
                          // Add Auto Layout constraints to center the label in the view
                          NSLayoutConstraint.activate([
                              self.sensorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                              self.sensorLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
                          ])
                   }
               }
           } catch {
               print("Error decoding JSON: \(error)")
           }
       }
    
    
    
    func fetchDataFromServer() {
        
        let accessToken = Auth.token.accessToken
        

        // 연결할 URL
        if let url = URL(string: "http://3.20.48.164:8000/plant/data/") {
            
            // URLSession 객체 생성
            let session = URLSession.shared
            
            // URL 요청을 위한 URLRequest 생성
                   var request = URLRequest(url: url)
                   
                   // 액세스 토큰을 사용하여 Authorization 헤더 추가
                   request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

                   // URLSession 데이터 작업 생성
                   let task = session.dataTask(with: request) { (data, response, error) in
                       // 에러 확인
                       if let error = error {
                           print("에러: \(error)")
                           return
                       }

                       if let data = data {
                                           // Call the updateUI function with the received JSON data
                                           self.updateUI(with: data)
                                       }
                                   }

                                   task.resume()
                               }
                           }
                           
    
    
    @objc func backButtonTapped() {
        // 화살표 버튼이 탭되었을 때 수행할 동작을 여기에 추가
        print("Back 버튼이 탭되었습니다.")
        // 화면을 닫고 이전 화면으로 돌아가기
        self.dismiss(animated: true, completion: nil)
    }
}
