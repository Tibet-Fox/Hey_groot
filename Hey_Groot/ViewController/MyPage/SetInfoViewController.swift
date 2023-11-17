import UIKit

class SetInfoViewController: UIViewController {
    // UITextField 선언
    private var textField: UITextField!
    
    // 서버 응답에서 닉네임을 추출하여 UITextField의 placeholder에 설정
       private func updatePlaceholderWithNickname(_ updatedNickname: String) {
           DispatchQueue.main.async {
               self.textField.placeholder = updatedNickname
           }
       }
    
    //업데이트된 닉네임을 저장할 변수
    private var updatedNickname: String?
    
    private var url: String? = "<http://3.20.48.164:8000/user/update/>"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 배경색 설정
        view.backgroundColor = .white

        // 네비게이션 바 설정
        self.title = "회원정보 수정"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        
        // 네비게이션 바의 왼쪽에 "sensor" 문구와 화살표 아이콘을 함께 표시
                let mypageItem = UIBarButtonItem(title: "Mypage", style: .plain, target: nil, action: nil)
                
                let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
                
                // 이미지와 타이틀 간 여백 조절
                mypageItem.imageInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: -10)
                
                // 두 개의 UIBarButtonItem을 UIStackView로 묶어서 표시
                let combinedItems = [backButton, mypageItem]
                self.navigationItem.leftBarButtonItems = combinedItems
        
        

        // 버튼 생성 및 설정
        let button = UIButton(type: .system)
        button.setTitle("수정", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 300, y: 300, width: 50, height: 50)
        button.layer.cornerRadius = 12
        button.layer.backgroundColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1).cgColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        

        // UITextField 생성 및 설정
        textField = UITextField(frame: CGRect(x: 40, y: 300, width: 250, height: 50))
        textField.placeholder = updatedNickname // Placeholder 설정
        textField.borderStyle = .roundedRect // 테두리 스타일 설정
        textField.delegate = self // UITextFieldDelegate 설정

        // 뷰에 추가
        self.view.addSubview(textField)
        self.view.addSubview(button)
    }

    // 서버에 닉네임 업데이트를 요청하는 함수
    private func updateNickname(_ nickname: String) {
        guard let updateUrlString = url, let apiUrl = URL(string: updateUrlString) else {
            print("Invalid URL for updating nickname")
            return
        }

        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = ["nickname": nickname]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Error creating JSON data: \(error)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP response status code: \(httpResponse.statusCode)")
                return
            }

            if let data = data, let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let updatedNickname = responseJSON["updatedNickname"] as? String {
                self.updatePlaceholderWithNickname(updatedNickname)
            } else {
                print("Invalid response data")
            }
        }

        task.resume()
    }

    
    
    
    
    
    
    
    //서버에서 업데이트된 닉네임을 추출하여 UITextField의 Flaceholder에 설정
    @objc func buttonTapped(_ sender: UIButton) {
        // 버튼이 탭되었을 때 수행할 동작을 여기에 추가
        print("Back to My Page 버튼이 탭되었습니다.")

        // 입력된 텍스트 출력
        if let text = textField.text {
            print("입력된 텍스트: \(text)")
    
            updateNickname(text)
            } else {
                print("텍스트를 입력하세요.")
        }
        
        // 화면을 닫고 이전 화면으로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func backButtonTapped() {
        // "Back" 버튼이 탭되었을 때 수행할 동작을 여기에 추가
        print("Back 버튼이 탭되었습니다.")
        // 화면을 닫고 이전 화면으로 돌아가기
        self.dismiss(animated: true, completion: nil)
    }
}

extension SetInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 텍스트 필드 리턴키 눌렀을 때 호출되는 메서드
        textField.resignFirstResponder() // 키보드 닫기
        return true
    }
}
