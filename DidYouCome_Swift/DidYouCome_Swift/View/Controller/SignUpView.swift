//
//  SignUpView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/13.
//

import UIKit
import RxSwift

class SignUpView: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var pwCheck: UITextField!
    @IBOutlet weak var school: UITextField!
    
    let viewModel: SignUpViewModel = SignUpViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUp(_ sender: Any) {
        if checkNil(text: name) && checkNil(text: id) && checkNil(text: password) && checkNil(text: pwCheck) && checkNil(text: school) {
            if password.text != pwCheck.text {
                let msg = "비밀번호와 비밀번호확인이 다릅니다. 다시 입력해주세요."
                makeAlert(title: "", msg: msg)
            }
            else if viewModel.MakeUser(id.text!, password: password.text!, school: school.text!, name: name.text!) {
                let msg = "회원가입이 완료되었습니다. 로그인을 해주세요."
                makeAlert(title: "성공", msg: msg)
            }
            else {
                let msg = "동일한 아이디를 사용하는 사람이 있습니다. 아이디를 다시 입력해주세요."
                makeAlert(title: "동일한 아이디 존재", msg: msg)
            }
        }
        let msg = "입력이 안된곳이 있습니다. 확인해주세요."
        makeAlert(title: "실패", msg: msg)
    }
    
    func makeAlert(title: String, msg: String) -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        var okAction: UIAlertAction
        if title == "성공" {
            okAction = UIAlertAction(title: "OK", style: .default,handler:  { (action) in
                self.presentingViewController?.dismiss(animated: true)
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
    
    @IBAction func ShowPwCheck(_ sender: Any) {
        if(pwCheck.isSecureTextEntry == true){
            pwCheck.isSecureTextEntry = false
        } else {
            pwCheck.isSecureTextEntry = true
        }
    }
    
    @IBAction func ShowLogin(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
