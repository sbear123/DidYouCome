//
//  StudentHomeView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/22.
//

import UIKit
import RxSwift

class StudentHomeView: UIViewController {
    
    let userData: UserViewModel = UserViewModel()
    
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var CheckTime: UILabel!
    @IBOutlet weak var CheckMain: UILabel!
    @IBOutlet weak var CheckAsk: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Check: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Time.text = userData.GetUser("time")
        let check = userData.GetUser("check")
        CheckTime.text = check
        CheckMain.text = check
        CheckAsk.text = check
        Check.setTitle(check, for: .normal)
        Name.text = userData.GetUser("name")
    }
    
    
}
