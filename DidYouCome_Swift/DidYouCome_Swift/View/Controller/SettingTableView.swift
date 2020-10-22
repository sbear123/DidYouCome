//
//  TableView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/22.
//

import UIKit

class TableView: UITableViewController {
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
    }
    
    func changePw() {
        //비밀번호바꾸기
    }
    
    func changeSchool() {
        //학교바꾸기
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
    
    func logOut() {
        removeKeys(keyName: "userid")
        removeKeys(keyName: "type")
        removeKeys(keyName: "pw")
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
