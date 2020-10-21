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
    @IBOutlet weak var lId: UITextField!
    @IBOutlet weak var lPassword: UITextField!
    
    let viewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ShowSignUp(_ sender: Any) {
        changePage(viewName: "signUp")
        print("Click")
    }
    
    @IBAction func Login(_ sender: Any) {
        print(checkNil(text: lId))
        if checkNil(text: lId) && checkNil(text: lPassword) {
            let result = viewModel.GetUser(lId.text!, password: lPassword.text!)
            if result == "student" {
                let msg = "로그인에 성공하셨습니다."
                makeAlert(title: "성공", msg: msg)
                changePage(viewName: "StudentView")
            }
            else if result == "teacher"{
                changePage(viewName: "TeacherView")
            }
            else {
                let msg = "아이디 혹은 비밀번호가 틀렸습니다. 다시 확인해주세요."
                makeAlert(title: "로그인 실패", msg: msg)
            }
        }
        let msg = "입력이 안된곳이 있습니다. 확인해주세요."
        makeAlert(title: "실패", msg: msg)
    }
    
    func makeAlert(title: String, msg: String) -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in }

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
