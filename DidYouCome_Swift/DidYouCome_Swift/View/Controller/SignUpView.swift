//
//  SignUpView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/13.
//

import UIKit
import RxSwift

class SignUpView: UIViewController {
    
    @IBOutlet weak var sName: UITextField!
    @IBOutlet weak var sId: UITextField!
    @IBOutlet weak var sPassword: UITextField!
    @IBOutlet weak var sPwCheck: UITextField!
    @IBOutlet weak var sSchool: UITextField!
    
    let viewModel: SignUpViewModel = SignUpViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) {(_) in
        })
        self.present (alert, animated:false)
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
    
    @IBAction func ShowLogin(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
