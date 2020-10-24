//
//  LoginView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/13.
//

import UIKit
import RxSwift

class LoginView: UIViewController {
    //login
    @IBOutlet weak var ShowPw: UIButton!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let viewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            print(result)
            let msg = "로그인에 성공하셨습니다."
            makeAlert(title: "성공", msg: msg, type: result)
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
}
