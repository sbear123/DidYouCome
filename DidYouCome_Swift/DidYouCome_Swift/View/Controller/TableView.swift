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
        if indexPath.row == 0 {
            checkLogOut()
        }
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
