//
//  AddPlantViewController.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/09/06.
//

import Foundation
import UIKit
import RxSwift
import Alamofire
class AddPlantViewController: UIViewController {

    let disposeBag = DisposeBag()
   // private let provider = MoyaProvider<Types>()
    
    @IBOutlet weak var plantLabel1: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var plantLabel2: UILabel!
    @IBOutlet weak var plantLabel3: UILabel!
    @IBOutlet weak var plantLabel4: UILabel!
    
    @IBOutlet weak var plantTextField1: UITextField!
    @IBOutlet weak var plantTextField2: UITextField!
    @IBOutlet weak var plantTextField3: UITextField!
    @IBOutlet weak var plantTextField4: UITextField!
    
    @IBOutlet weak var characterBtn: UIButton!
    @IBOutlet weak var addPlantBtn: UIButton!
    
    let birthdatePicker = UIDatePicker()
    let waterdatePicker = UIDatePicker()
    var plantName: String?

    var plant_Item:[String]?
    var characterInfo:CharacterInfo?
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        let addPlantParent = self.view!
       // addPlantParent.addSubview(addPlantLabel)
        addPlantParent.addSubview(plantLabel1)
        addPlantParent.addSubview(searchBtn)
        addPlantParent.addSubview(plantLabel2)
        addPlantParent.addSubview(plantLabel3)
        addPlantParent.addSubview(plantLabel4)
        addPlantParent.addSubview(characterBtn)
        addPlantParent.addSubview(addPlantBtn)
        addPlantParent.addSubview(plantTextField1)
        addPlantParent.addSubview(plantTextField2)
        addPlantParent.addSubview(plantTextField3)
        addPlantParent.addSubview(plantTextField4)
        
        setupBirthTextField()
        setupBirthToolBar()
        setupBirthDatePicker()
        
        setupWaterTextField()
        setupWaterToolBar()
        setupWaterDatePicker()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.21
        

       

        plantLabel1.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        plantLabel1.attributedText = NSMutableAttributedString(string: "식물 종류", attributes: [NSAttributedString.Key.kern: -0.3, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        plantLabel1.translatesAutoresizingMaskIntoConstraints = false
        plantLabel1.widthAnchor.constraint(equalToConstant: 59).isActive = true
        plantLabel1.heightAnchor.constraint(equalToConstant: 26).isActive = true
        plantLabel1.leadingAnchor.constraint(equalTo: addPlantParent.leadingAnchor, constant: 16).isActive = true
        plantLabel1.topAnchor.constraint(equalTo: addPlantParent.topAnchor, constant: 164).isActive = true

        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        searchBtn.widthAnchor.constraint(equalToConstant: 22).isActive = true
        searchBtn.heightAnchor.constraint(equalToConstant: 22).isActive = true
        searchBtn.leadingAnchor.constraint(equalTo: addPlantParent.leadingAnchor, constant: 350).isActive = true
        searchBtn.topAnchor.constraint(equalTo: addPlantParent.topAnchor, constant: 216).isActive = true

        

        plantTextField1.backgroundColor =  UIColor(red: 0.949, green: 0.957, blue: 0.965, alpha: 1)
        plantTextField1.layer.cornerRadius = 20
        plantTextField1.translatesAutoresizingMaskIntoConstraints = false
        plantTextField1.widthAnchor.constraint(equalToConstant: 326).isActive = true
        plantTextField1.heightAnchor.constraint(equalToConstant: 54).isActive = true
        plantTextField1.leadingAnchor.constraint(equalTo: addPlantParent.leadingAnchor, constant: 16).isActive = true
        plantTextField1.topAnchor.constraint(equalTo: addPlantParent.topAnchor, constant: 200).isActive = true
    
        

        plantLabel2.frame = CGRect(x: 0, y: 0, width: 59, height: 26)
        plantLabel2.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        plantLabel2.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        plantLabel2.attributedText = NSMutableAttributedString(string: "식물 애칭", attributes: [NSAttributedString.Key.kern: -0.3, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        plantLabel2.translatesAutoresizingMaskIntoConstraints = false
        plantLabel2.widthAnchor.constraint(equalToConstant: 59).isActive = true
        plantLabel2.heightAnchor.constraint(equalToConstant: 26).isActive = true
        plantLabel2.leadingAnchor.constraint(equalTo: addPlantParent.leadingAnchor, constant: 16).isActive = true
        plantLabel2.topAnchor.constraint(equalTo: addPlantParent.topAnchor, constant: 282).isActive = true
        
        plantTextField2.frame = CGRect(x: 0, y: 0, width: 358, height: 54)
        plantTextField2.backgroundColor =  UIColor(red: 0.949, green: 0.957, blue: 0.965, alpha: 1)
        plantTextField2.layer.cornerRadius = 25
        plantTextField2.translatesAutoresizingMaskIntoConstraints = false
        plantTextField2.widthAnchor.constraint(equalToConstant: 358).isActive = true
        plantTextField2.heightAnchor.constraint(equalToConstant: 54).isActive = true
        plantTextField2.leadingAnchor.constraint(equalTo: addPlantParent.leadingAnchor, constant: 16).isActive = true
        plantTextField2.topAnchor.constraint(equalTo: addPlantParent.topAnchor, constant: 318).isActive = true


        plantLabel3.frame = CGRect(x: 0, y: 0, width: 90, height: 26)
        plantLabel3.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        plantLabel3.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        plantLabel3.attributedText = NSMutableAttributedString(string: "식물 입양한 날", attributes: [NSAttributedString.Key.kern: -0.3, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        plantLabel3.translatesAutoresizingMaskIntoConstraints = false
        plantLabel3.widthAnchor.constraint(equalToConstant: 90).isActive = true
        plantLabel3.heightAnchor.constraint(equalToConstant: 26).isActive = true
        plantLabel3.leadingAnchor.constraint(equalTo: addPlantParent.leadingAnchor, constant: 16).isActive = true
        plantLabel3.topAnchor.constraint(equalTo: addPlantParent.topAnchor, constant: 400).isActive = true
        
        plantTextField3.frame = CGRect(x: 0, y: 0, width: 358, height: 54)
        plantTextField3.backgroundColor =  UIColor(red: 0.949, green: 0.957, blue: 0.965, alpha: 1)
        plantTextField3.layer.cornerRadius = 20
        plantTextField3.translatesAutoresizingMaskIntoConstraints = false
        plantTextField3.widthAnchor.constraint(equalToConstant: 358).isActive = true
        plantTextField3.heightAnchor.constraint(equalToConstant: 54).isActive = true
        plantTextField3.leadingAnchor.constraint(equalTo: addPlantParent.leadingAnchor, constant: 16).isActive = true
        plantTextField3.topAnchor.constraint(equalTo: addPlantParent.topAnchor, constant: 436).isActive = true
        

        plantLabel4.frame = CGRect(x: 0, y: 0, width: 90, height: 26)
        plantLabel4.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        plantLabel4.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        plantLabel4.attributedText = NSMutableAttributedString(string: "마지막 물준 날", attributes: [NSAttributedString.Key.kern: -0.3, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        plantLabel4.translatesAutoresizingMaskIntoConstraints = false
        plantLabel4.widthAnchor.constraint(equalToConstant: 90).isActive = true
        plantLabel4.heightAnchor.constraint(equalToConstant: 26).isActive = true
        plantLabel4.leadingAnchor.constraint(equalTo: addPlantParent.leadingAnchor, constant: 16).isActive = true
        plantLabel4.topAnchor.constraint(equalTo: addPlantParent.topAnchor, constant: 518).isActive = true
        
        plantTextField4.frame = CGRect(x: 0, y: 0, width: 358, height: 54)
        plantTextField4.backgroundColor = UIColor(red: 0.949, green: 0.957, blue: 0.965, alpha: 1)
        plantTextField4.layer.cornerRadius = 25
        plantTextField4.translatesAutoresizingMaskIntoConstraints = false
        plantTextField4.widthAnchor.constraint(equalToConstant: 358).isActive = true
        plantTextField4.heightAnchor.constraint(equalToConstant: 54).isActive = true
        plantTextField4.leadingAnchor.constraint(equalTo: addPlantParent.leadingAnchor, constant: 16).isActive = true
        plantTextField4.topAnchor.constraint(equalTo: addPlantParent.topAnchor, constant: 554).isActive = true
        
    
        characterBtn.frame = CGRect(x: 0, y: 0, width: 358, height: 57)
        characterBtn.layer.backgroundColor = UIColor(red: 254/255, green: 208/255, blue: 129/255, alpha: 1).cgColor
        characterBtn.layer.cornerRadius = 12
        characterBtn.translatesAutoresizingMaskIntoConstraints = false
        characterBtn.widthAnchor.constraint(equalToConstant: 358).isActive = true
        characterBtn.heightAnchor.constraint(equalToConstant: 57).isActive = true
        characterBtn.leadingAnchor.constraint(equalTo: addPlantParent.leadingAnchor, constant: 16).isActive = true
        characterBtn.topAnchor.constraint(equalTo: addPlantParent.topAnchor, constant: 678).isActive = true
        characterBtn.setTitle("캐릭터 만들기", for: .normal)
        characterBtn.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

        
        addPlantBtn.frame = CGRect(x: 0, y: 0, width: 358, height: 57)
        addPlantBtn.layer.backgroundColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1).cgColor
        addPlantBtn.layer.cornerRadius = 12
        addPlantBtn.translatesAutoresizingMaskIntoConstraints = false
        addPlantBtn.widthAnchor.constraint(equalToConstant: 358).isActive = true
        addPlantBtn.heightAnchor.constraint(equalToConstant: 57).isActive = true
        addPlantBtn.leadingAnchor.constraint(equalTo: addPlantParent.leadingAnchor, constant: 16).isActive = true
        addPlantBtn.topAnchor.constraint(equalTo: addPlantParent.topAnchor, constant: 740).isActive = true
        addPlantBtn.setTitle("완료하기", for: .normal)
        addPlantBtn.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
      }
    
    
    @IBAction func pressCharacterBtn(_ sender: UIButton) {
       let controller = AddCharacterViewController()
        controller.viewController = self
        
        self.present(controller,animated: true)
    }
    
    
    @IBAction func pressAddPlantBtn(_ sender: UIButton) {
      gotoMainView()
    }
    
    @IBAction func pressSearchBtn(_ sender: UIButton) {
        self.gotoSearchView()
    }
    
    
    func gotoMainView() {
        if plant_Item?.count == 0 || plantTextField2.text == "" || characterInfo == nil{
            let alert = UIAlertController(title: "Error", message: "입력을 하지않은 공간이 있습니다.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default)
            alert.addAction(action)
            self.present(alert,animated: true)
          
        }else{
            Observable.just("http://3.20.48.164:8000/plant/partner/")
                .map { url -> ApiRequest in
                    var params = [String:Any]()
                    params["character_id"] = String( self.characterInfo?.id ?? 0) 
                    params["name"] = self.plantTextField1.text
                    params["plant_id"] = self.plant_Item?[0] ?? ""
                    let header = HTTPHeader(name: "Authorization", value: "Bearer \(Auth.token.accessToken)")
                    return ApiRequest(params: params, url: url, header: header)
                }.flatMap { api -> Observable<ResponseMessage> in
                    return getRequest(api,.post)
                }.bind { data in
                    let alert = UIAlertController(title: "Info", message: "등록완료 했습니다.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default){ _ in
                        self.dismiss(animated: true)
                    }
                    alert.addAction(action)
                    self.present(alert,animated: true)
                    
                }
                .disposed(by: disposeBag)
        }
        
        func gotoMainmainView() {
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
        
        
        
        
       /* let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // 홈 뷰 컨트롤러 생성
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        homeViewController.loadViewIfNeeded()
   
        // 탭 바 뷰 컨트롤러 생성
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
        
        // 네비게이션 컨트롤러 생성
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        // 탭 바 뷰 컨트롤러에 네비게이션 컨트롤러 설정
        tabBarController.viewControllers = [navigationController]
        
        // 모달로 화면 표시
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)*/
    }
    
    func gotoSearchView(){
        guard let gotoSearchVC = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
                return
            }
        gotoSearchVC.viewController = self
        gotoSearchVC.modalTransitionStyle = .crossDissolve
        gotoSearchVC.modalPresentationStyle = .fullScreen
            present(gotoSearchVC, animated: true, completion: nil)
    }
    
    func setPlantInfo(_ item:[String]){
        plant_Item = item
        plantTextField1.text = item[2]
    }
}

//birthdatePicker
extension AddPlantViewController{
    
    private func setupBirthDatePicker() {
        // datePickerModed에는 time, date, dateAndTime, countDownTimer가 존재
        birthdatePicker.datePickerMode = .date
        // datePicker 스타일을 설정합니다. wheels, inline, compact, automatic이 존재합니다.
        birthdatePicker.preferredDatePickerStyle = .wheels
        birthdatePicker.locale = Locale(identifier: "ko-KR")
        // 값이 변할 때마다 동작을 설정
        birthdatePicker.addTarget(self, action: #selector(birthDateChange), for: .valueChanged)
        // nil이면 키보드 기본 할당
        plantTextField3.inputView = birthdatePicker
        // brithTextField에 오늘 날짜로 표시되게 설정
        plantTextField3.text = birthDateFormat(date: Date())
    }
    
    // 값이 변할 때 마다 동작
    @objc func birthDateChange(_ sender: UIDatePicker) {
        // 값이 변하면 UIDatePicker에서 날자를 받아와 형식을 변형해서 textField에 입력
        plantTextField3.text = birthDateFormat(date: sender.date)
    }
    
    // 텍스트 필드에 들어갈 텍스트를 DateFormatter 변환
    private func birthDateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        
        return formatter.string(from: date)
    }
    
    // 툴바 세팅
    private func setupBirthToolBar() {
        
        let toolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBirthButtonHandeler))
        
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        
        // textField의 경우 클릭 시 키보드 위에 AccessoryView가 표시
        // 현재 inputView를 datePicker로 만들어 줬으니 datePicker위에 표시됨
        plantTextField3.inputAccessoryView = toolBar
    }
    
    @objc func doneBirthButtonHandeler(_ sender: UIBarButtonItem) {
        plantTextField3.text = birthDateFormat(date: birthdatePicker.date)
        // 키보드 내리기
        plantTextField3.resignFirstResponder()
    }
    
    private func setupBirthTextField() {
        view.addSubview(plantTextField3)
    }
    
}

//waterdatePicker
extension AddPlantViewController{
    
    private func setupWaterDatePicker() {
        waterdatePicker.preferredDatePickerStyle = .wheels
        waterdatePicker.locale = Locale(identifier: "ko-KR")
        waterdatePicker.addTarget(self, action: #selector(waterDateChange), for: .valueChanged)
        plantTextField4.inputView = waterdatePicker
        plantTextField4.text = waterDateFormat(date: Date())
    }
    
    // 값이 변할 때 마다 동작
    @objc func waterDateChange(_ sender: UIDatePicker) {
        plantTextField4.text = waterDateFormat(date: sender.date)
    }
    
    // 텍스트 필드에 들어갈 텍스트를 DateFormatter 변환
    private func waterDateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd HH:mm"
        
        return formatter.string(from: date)
    }
    
    private func setupWaterToolBar() {
        
        let toolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneWaterButtonHandeler))
        
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        
        // textField의 경우 클릭 시 키보드 위에 AccessoryView가 표시
        // 현재 inputView를 datePicker로 만들어 줬으니 datePicker위에 표시됨
        plantTextField4.inputAccessoryView = toolBar
    }
    
    @objc func doneWaterButtonHandeler(_ sender: UIBarButtonItem) {
        plantTextField4.text = waterDateFormat(date: waterdatePicker.date)
        plantTextField4.resignFirstResponder()
    }
    
    private func setupWaterTextField() {
        view.addSubview(plantTextField4)
    }
    
}
