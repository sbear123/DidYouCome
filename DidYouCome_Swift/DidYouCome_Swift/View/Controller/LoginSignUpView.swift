//
//  LoginSignUpView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/13.
//

import UIKit
import RxSwift

class LoginSignUpView: UIViewController {
    //login
    @IBOutlet weak var lId: UITextField!
    @IBOutlet weak var lPassword: UITextField!
    
    //signup
    @IBOutlet weak var sName: UITextField!
    @IBOutlet weak var sId: UITextField!
    @IBOutlet weak var sPassword: UITextField!
    @IBOutlet weak var sPwCheck: UITextField!
    @IBOutlet weak var sSchool: UITextField!
    
    let viewModel: LoginViewModel = LoginViewModel()
    
    @IBOutlet weak var topContraintHeight: NSLayoutConstraint!
    
    @IBAction func ShowSignUp(_ sender: Any) {
        topContraintHeight.constant = 0;
        UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
        print("Click")
    }
    
    @IBAction func ShowLogin(_ sender: Any) {
        topContraintHeight.constant = 900;
        UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
        print("Click")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        topContraintHeight.constant = 900;
    }
    @IBAction func SignUp(_ sender: Any) {
        if checkNil(text: sName) && checkNil(text: sId) && checkNil(text: sPassword) && checkNil(text: sPwCheck) && checkNil(text: sSchool) {
            if sPassword.text != sPwCheck.text {
                let msg = "비밀번호와 비밀번호확인이 다릅니다. 다시 입력해주세요."
                makeAlert(title: "", msg: msg)
            }
            else if viewModel.MakeUser(sId.text!, password: sPassword.text!, school: sSchool.text!, name: sName.text!) {
                let msg = "회원가입이 완료되었습니다. 로그인을 해주세요."
                makeAlert(title: "성공", msg: msg)
                topContraintHeight.constant = 900;
                UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
            }
            else {
                let msg = "동일한 아이디를 사용하는 사람이 있습니다. 아이디를 다시 입력해주세요."
                makeAlert(title: "동일한 아이디 존재", msg: msg)
            }
        }
    }
    
    @IBAction func Login(_ sender: Any) {
        if checkNil(text: sId) && checkNil(text: sPassword) {
            let result = viewModel.GetUser(sId.text!, password: sPassword.text!)
            if result != "fail" {
                let msg = "로그인에 성공하셨습니다."
                makeAlert(title: "성공", msg: msg)
                if result == "student" {
                    changePage(viewName: "StudentView")
                }
                else {
                    changePage(viewName: "TeacherView")
                }
            }
            else {
                let msg = "아이디 혹은 비밀번호가 틀렸습니다. 다시 확인해주세요."
                makeAlert(title: "로그인 실패", msg: msg)
            }
        }
    }
    
    func makeAlert(title: String, msg: String) -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) {(_) in
        })
        self.present (alert, animated:false)
    }
    
    func checkNil(text: UITextField) -> Bool {
        let msg = viewModel.CheckNull(text.text!)
        if msg != "" {
            makeAlert(title: "", msg: msg)
            return false
        }
        return true
    }
    
    func changePage(viewName: String) -> Void {
        //storyboard를 통해 두번쨰 화면의 storyboard ID를 참조하여 뷰 컨트롤러를 가져옵니다.
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "TeacherView") else{
            return
        }
        //화면 전환 애니메이션을 설정합니다.
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        //인자값으로 다음 뷰 컨트롤러를 넣고 present 메소드를 호출합니다.
        self.present(uvc, animated: true)
    }
}
