//
//  LoginViewController.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/08/20.
//

import Foundation
import UIKit
import Moya


class LoginViewController: UIViewController {
    
    private let provider = MoyaProvider<Types>()
    
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    override func viewDidLoad() {
        
        let parent = self.view!
        parent.addSubview(logoImage)
        parent.addSubview(emailTextField)
        parent.addSubview(passwordTextField)
        parent.addSubview(registerBtn)
        parent.addSubview(loginBtn)
        
        
        logoImage.frame = CGRect(x: 0, y: 0, width: 119.69, height: 53.61)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.widthAnchor.constraint(equalToConstant: 119.69).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 53.61).isActive = true
        logoImage.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 16).isActive = true
        logoImage.topAnchor.constraint(equalTo: parent.topAnchor, constant: 144).isActive = true
        
        emailTextField.borderStyle = .roundedRect
        emailTextField.frame = CGRect(x: 0, y: 0, width: 358, height: 50)
        emailTextField.layer.cornerRadius = 5
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(red: 0.889, green: 0.894, blue: 0.9, alpha: 1).cgColor
        emailTextField.placeholder = "이메일을 입력해주세요."
        
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.frame = CGRect(x: 0, y: 0, width: 358, height: 50)
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(red: 0.889, green: 0.894, blue: 0.9, alpha: 1).cgColor
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "비밀번호를 입력해주세요."
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.widthAnchor.constraint(equalToConstant: 358).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 16).isActive = true
        emailTextField.topAnchor.constraint(equalTo: parent.topAnchor, constant: 274).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.widthAnchor.constraint(equalToConstant: 358).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 16).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: parent.topAnchor, constant: 345).isActive = true
        
        
        loginBtn.frame = CGRect(x: 0, y: 0, width: 358, height: 57)
        loginBtn.layer.backgroundColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1).cgColor
        loginBtn.layer.cornerRadius = 12
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.widthAnchor.constraint(equalToConstant: 358).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 57).isActive = true
        loginBtn.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 16).isActive = true
        loginBtn.topAnchor.constraint(equalTo: parent.topAnchor, constant: 437).isActive = true
        loginBtn.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        loginBtn.setTitle("로그인하기", for: .normal)

        
        
        registerBtn.frame = CGRect(x: 0, y: 0, width: 358, height: 57)
        registerBtn.layer.backgroundColor = UIColor(red: 254/255, green: 208/255, blue: 129/255, alpha: 1).cgColor
        registerBtn.layer.cornerRadius = 12
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.widthAnchor.constraint(equalToConstant: 358).isActive = true
        registerBtn.heightAnchor.constraint(equalToConstant: 57).isActive = true
        registerBtn.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 16).isActive = true
        registerBtn.topAnchor.constraint(equalTo: parent.topAnchor, constant: 500).isActive = true
        registerBtn.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        registerBtn.setTitle("회원가입하기", for: .normal)
        
    }
    
    
    
    @IBAction func pressLoginBtn(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            print("error")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            print("error")
            return
            
        }
        
       login(email: email, password: password)
        //self.gotoMainView()
        
    }
    
    func gotoMainView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // 홈 뷰 컨트롤러 생성
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        // HomeViewController의 뷰를 로드합니다.
        homeViewController.loadViewIfNeeded()
        
        // 탭 바 뷰 컨트롤러 생성
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
        
        // 네비게이션 컨트롤러 생성
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        // 탭 바 뷰 컨트롤러에 네비게이션 컨트롤러 설정
        tabBarController.viewControllers = [navigationController]
        
        // 모달로 화면 표시
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)
    }

    
    
    @MainActor
    func login(email: String, password: String) {
        provider.request(.postLogin(email: email, password: password)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                   
                    print( (try response.mapJSON()) as? [String:Any] ?? [String:Any]())
                    let refreshToken = try response.map(PostLogin.self).refresh_token
                    let accessToken = try response.map(PostLogin.self).access_token
                    let user =  try response.map(PostLogin.self).user
                    Auth.token.user = user
                    Auth.token.accessToken = accessToken
                    Auth.token.refreshToken = refreshToken
                    self?.gotoMainView()
                } catch (let err) {
                    print(err)
                    let alert = UIAlertController(title: "Error", message: "아이디 비밀번호를 확인해주세요.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(action)
                    self?.present(alert,animated: true)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    @IBAction func pressRegisterBtn(_ sender: UIButton) {
        guard let gotoRegisterVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else { return }
        gotoRegisterVC.modalTransitionStyle = .crossDissolve
        gotoRegisterVC.modalPresentationStyle = .fullScreen
        self.present(gotoRegisterVC, animated: true, completion: nil)
    }
    
    
}
