//
//  TabBarViewController.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/11/04.
//

import UIKit
import RxSwift

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    let userView: UserView = UserView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func changeTab() {
        super.viewDidLoad()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            changeTab()
        }
}

