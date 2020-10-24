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

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Check: UILabel!
    @IBOutlet weak var School: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Name.text = userData.GetUser("name") + "님,"
        if userData.GetUser("type") == "student"{
            Check.text = "현재" + userData.GetUser("check") + "상태"
        } else {
            School.text = userData.GetUser("school")
        }
    }
}
