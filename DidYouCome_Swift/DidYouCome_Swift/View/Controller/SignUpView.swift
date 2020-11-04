//
//  SignUpView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/13.
//

import UIKit
import RxSwift

class SignUpView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var ShowPw: UIButton!
    @IBOutlet weak var ShowPwCheck: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var pwCheck: UITextField!
    @IBOutlet weak var school: UITextField!
    
    var height = 0 //키보드 높이
    //비밀번호 정규식
    
    let viewModel: SignUpViewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.id.delegate = self
        self.name.delegate = self
        self.password.delegate = self
        self.pwCheck.delegate = self
        self.school.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    @IBAction func SignUp(_ sender: Any) {
        if checkNil(text: name) && checkNil(text: id) && checkNil(text: password) && checkNil(text: pwCheck) && checkNil(text: school) {
            if password.text != pwCheck.text {
                let msg = "비밀번호와 비밀번호확인이 다릅니다. 다시 입력해주세요."
                makeAlert(title: "", msg: msg)
            }
            else if !validatePassword() {
                let msg = "비밀번호가 너무 약합니다. 다시 입력해주세요."
                makeAlert(title: "", msg: msg)
            }
            else if viewModel.CheckSchool(school: school.text!) {
                let msg = "존재하지 않는 학교 입니다. 다시 입력해주세요."
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
                self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func ShowPwCheck(_ sender: Any) {
        if(pwCheck.isSecureTextEntry == true){
            ShowPwCheck.setImage(UIImage(systemName: "eye"), for: .normal)
            pwCheck.isSecureTextEntry = false
        } else {
            ShowPwCheck.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            pwCheck.isSecureTextEntry = true
        }
    }
    
    @IBAction func ShowLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan (_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        self.view.frame.origin.y += CGFloat(self.height)
        self.height = 0
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.id:
            self.name.becomeFirstResponder()
        case self.name:
            self.password.becomeFirstResponder()
        case self.password:
            self.pwCheck.becomeFirstResponder()
        case self.pwCheck:
            self.school.becomeFirstResponder()
        default:
            self.school.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    @objc func keyboardWillAppear(_ sender: NotificationCenter){
        if (height != 200){
            self.view.frame.origin.y -= 200
            self.height += 200
        }
    }
    
    @objc func keyboardWillDisappear(_ sender: NotificationCenter){
        self.view.frame.origin.y += CGFloat(self.height)
        self.height = 0
    }
    
    func validatePassword() -> Bool {
        let pwRegEx = "(?=.*[A-Za-z])(?=.*[0-9]).{6,20}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", pwRegEx)
        return predicate.evaluate(with: self.password.text)
    }
    
}
