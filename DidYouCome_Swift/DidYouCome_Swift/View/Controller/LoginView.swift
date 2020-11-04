//
//  LoginView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/13.
//

import UIKit
import RxSwift

class LoginView: UIViewController, UITextFieldDelegate {
    //login
    @IBOutlet weak var ShowPw: UIButton!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var Loading: UIView!
    
    let viewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.Loading.isHidden = true
        setLoadView(name: "LoadingView", width: 414, height: 896)
        self.id.delegate = self
        self.password.delegate = self
    }
    
    @IBAction func ShowSignUp(_ sender: Any) {
        print("Click")
    }
    
    @IBAction func Login(_ sender: Any) {
        print(checkNil(text: id))
        if checkNil(text: id) && checkNil(text: password) {
            let result = viewModel.GetUser(id.text!, password: password.text!)
            if result == "fail"{
                let msg = "아이디 혹은 비밀번호가 틀렸습니다. 다시 확인해주세요."
                makeAlert(title: "로그인 실패", msg: msg, type: nil)
            }
            viewModel.AutoLogin(userid: id.text!)
            UserDefaults.standard.set(result, forKey: "type")
            print(result)
            let msg = "로그인에 성공하셨습니다."
            makeAlert(title: "성공", msg: msg, type: result)
            self.Loading.isHidden = false
        }
        let msg = "입력이 안된곳이 있습니다. 확인해주세요."
        makeAlert(title: "실패", msg: msg, type: nil)
    }
    
    func makeAlert(title: String, msg: String, type: String?) -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        var okAction : UIAlertAction
        if title == "성공" {
            okAction = UIAlertAction(title: "OK", style: .default,handler:  { (action) in
                self.changePage(viewName: type!)
            })
        } else {
            okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    
    func checkNil(text: UITextField) -> Bool {
        print(text.text!)
        if text.text == "" {
            return false
        }
        return true
    }
    
    @IBAction func ShowPw(_ sender: Any) {
        if(password.isSecureTextEntry == true){
            ShowPw.setImage(UIImage(systemName: "eye"), for: .normal)
            password.isSecureTextEntry = false
        } else {
            ShowPw.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            password.isSecureTextEntry = true
        }
    }
    
    func changePage(viewName: String) -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: viewName)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
    
    func setLoadView(name: String, width:Int, height: Int) -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: UIViewController = storyboard.instantiateViewController(withIdentifier: name) as UIViewController
        addChild(controller)
        Loading.addSubview(controller.view)
        controller.view.frame = view.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // tell the childviewcontroller it's contained in it's parent
        controller.didMove(toParent: self)
        controller.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.id:
            self.password.becomeFirstResponder()
        default:
            self.password.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
