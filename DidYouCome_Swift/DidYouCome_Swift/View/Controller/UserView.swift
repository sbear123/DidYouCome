//
//  SuserView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/15.
//

import UIKit
import RxSwift

class UserView: UIViewController {
    
    let userData: UserViewModel = UserViewModel()
    
    @IBOutlet var UIView: UIView!
    @IBOutlet public var Name: UILabel!
    @IBOutlet public var Check: UILabel!
    @IBOutlet public var School: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Name.text = userData.GetUser("name") + "님,"
        if userData.GetUser("type") == "student"{
            Check.text = "현재 " + userData.GetUser("check") + "상태"
        } else {
            School.text = userData.GetUser("school")
        }
    }
    
}
