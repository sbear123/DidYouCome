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
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var AutoLogin: UISwitch!
    
    let viewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if UserDefaults.standard.string(forKey: "id") != nil{
            if UserDefaults.standard.string(forKey: "type") == "student" {
                changePage(viewName: "StudentView")
            } else {
                changePage(viewName: "TeacherView")
            }
        }

    }
    
    @IBAction func ShowSignUp(_ sender: Any) {
        changePage(viewName: "signUp")
        print("Click")
    }
    
    @IBAction func Login(_ sender: Any) {
        print(checkNil(text: id))
        if checkNil(text: id) && checkNil(text: password) {
            let result = viewModel.GetUser(id.text!, password: password.text!)
            if result == "student" {
                if AutoLogin.isOn{
                    UserDefaults.standard.set(self.id.text, forKey: "id")
                    UserDefaults.standard.set(self.password.text, forKey: "pwd")
                    UserDefaults.standard.set(result, forKey: "type")
                    
                    UserDefaults.standard.synchronize()
                } else {
                    UserDefaults.standard.set(nil, forKey: "id")
                    UserDefaults.standard.set(nil, forKey: "pwd")
                    UserDefaults.standard.set(nil, forKey: "type")
                    
                    UserDefaults.standard.synchronize()
                }
                let msg = "로그인에 성공하셨습니다."
                makeAlert(title: "성공", msg: msg, type: "StudentView")
            }
            else if result == "teacher"{
                let msg = "로그인에 성공하셨습니다."
                makeAlert(title: "성공", msg: msg, type: "TeacherView")
            }
            else {
                let msg = "아이디 혹은 비밀번호가 틀렸습니다. 다시 확인해주세요."
                makeAlert(title: "로그인 실패", msg: msg, type: nil)
            }
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
            password.isSecureTextEntry = false
        } else {
            password.isSecureTextEntry = true
        }
    }
    
    func changePage(viewName: String) -> Void {
        //storyboard를 통해 두번쨰 화면의 storyboard ID를 참조하여 뷰 컨트롤러를 가져옵니다.
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: viewName) else{
            return
        }
        //화면 전환 애니메이션을 설정합니다.
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        //인자값으로 다음 뷰 컨트롤러를 넣고 present 메소드를 호출합니다.
        self.present(uvc, animated: true)
    }
}
