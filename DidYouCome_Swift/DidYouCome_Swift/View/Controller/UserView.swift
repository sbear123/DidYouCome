//
//  SuserView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/15.
//

import UIKit
import RxSwift

class UserView: UIViewController {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Check: UILabel!
    @IBOutlet weak var School: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Name.text = UserDefaults.standard.string(forKey: "name")! + "님,"
        if UserDefaults.standard.string(forKey: "type") == "student"{
            Check.text = "현재" + UserDefaults.standard.string(forKey: "check")! + "상태"
        } else {
            School.text = UserDefaults.standard.string(forKey: "school")
        }
    }
}
