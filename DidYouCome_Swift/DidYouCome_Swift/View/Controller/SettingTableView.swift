//
//  TableView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/22.
//

import UIKit

class TableView: UITableViewController {
    
    let viewModel: SettingViewModel = SettingViewModel()
    let user: UserViewModel = UserViewModel()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if UserDefaults.standard.string(forKey: "type") == "teacher"{
            if indexPath.row == 0 {
                checkLogOut()
            }
        } else {
            if indexPath.section == 0 {
                switch indexPath.row {
                case 0:
                    changeName()
                case 1:
                    changePw()
                case 2:
                    changeSchool()
                default:
                    return
                }
            } else {
                if indexPath.row == 0 {
                    checkLogOut()
                }
            }
        }
        
    }
    
    func changeName() {
        //이름바꾸기
        let profileAlert = UIAlertController(title: "이름 변경", message: nil, preferredStyle: .alert)
        
        profileAlert.addTextField() { (tf) in
            tf.placeholder = "New Name"
        }
        
        profileAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        profileAlert.addAction(UIAlertAction(title: "완료", style: .destructive) { (_) in
            let name = profileAlert.textFields?[0].text ?? ""
            
            if self.viewModel.ChangeName(name) {
                let alert = UIAlertController(title: "성공", message: "이름 변경에 성공하셨습니다.", preferredStyle: .alert)
                var okAction : UIAlertAction
                okAction = UIAlertAction(title: "OK", style: .default){ (action) in
                    self.user.SetUser(key: name, keyName: "name")
                }
                alert.addAction(okAction)
                self.present(alert, animated: false, completion: nil)
            } else {
                self.makeAlert(title: "실패", msg: "이름 변경에 실패하셨습니다.")
            }
        })
        self.present(profileAlert, animated: true)
    }
    
    func changePw() {
        //비밀번호바꾸기
        let profileAlert = UIAlertController(title: "비밀번호 수정", message: nil, preferredStyle: .alert)
        
        profileAlert.addTextField() { (tf) in
            tf.placeholder = "Old Password"
        }
        profileAlert.addTextField() { (tf) in
            tf.placeholder = "New Password"
        }
        
        profileAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        profileAlert.addAction(UIAlertAction(title: "완료", style: .destructive) { (_) in
            let oldPw = profileAlert.textFields?[0].text ?? ""
            let newPw = profileAlert.textFields?[1].text ?? ""
            
            if self.viewModel.CheckPw(Pw: oldPw) {
                if self.viewModel.ChangePw(newPw){
                    self.makeAlert(title: "성공", msg: "비밀번호 변경에 성공하셨습니다.")
                }
            } else {
                self.makeAlert(title: "실패", msg: "비밀번호가 틀리셨습니다. 다시 시도해주십시오.")
            }
        })
        self.present(profileAlert, animated: true)
    }
    
    func changeSchool() {
        //학교바꾸기
        let profileAlert = UIAlertController(title: "학교 변경", message: nil, preferredStyle: .alert)
        
        profileAlert.addTextField() { (tf) in
            tf.placeholder = "New School"
        }
        
        profileAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        profileAlert.addAction(UIAlertAction(title: "완료", style: .destructive) { (_) in
            let School = profileAlert.textFields?[0].text ?? ""
            
            if self.viewModel.ChangeSchool(School) {
                let alert = UIAlertController(title: "성공", message: "학교 변경에 성공하셨습니다.", preferredStyle: .alert)
                var okAction : UIAlertAction
                okAction = UIAlertAction(title: "OK", style: .default){ (action) in
                    self.user.SetUser(key: School, keyName: "school")
                }
                alert.addAction(okAction)
                self.present(alert, animated: false, completion: nil)
            } else {
                self.makeAlert(title: "실패", msg: "학교 변경에 실패하셨습니다.")
            }
        })
        self.present(profileAlert, animated: true)
    }
    
    func checkLogOut() {
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        var okAction : UIAlertAction
        var cancel : UIAlertAction
        
        okAction = UIAlertAction(title: "예", style: .destructive,handler:  { (action) in
            self.logOut()
        })
        cancel = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancel)
        present(alert, animated: false, completion: nil)
    }
    
    func makeAlert(title: String, msg: String) -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        var okAction : UIAlertAction
        okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    
    func logOut() {
        removeKeys(keyName: "userid")
        removeKeys(keyName: "type")
        removeKeys(keyName: "time")
        removeKeys(keyName: "school")
        removeKeys(keyName: "name")
        removeKeys(keyName: "check")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
    }
    
    func removeKeys(keyName: String) {
        UserDefaults.standard.removeObject(forKey: keyName)
    }
}
