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
    let viewModel: SHomeViewModel = SHomeViewModel()
    
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var CheckTime: UILabel!
    @IBOutlet weak var CheckMain: UILabel!
    @IBOutlet weak var CheckAsk: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Check: UIButton!
    
    var check: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeText()
    }
    
    @IBAction func CheckInCheckOut(_ sender: Any) {
        if check == "퇴실" {
            viewModel.CheckIn()
        } else {
            viewModel.CheckOut()
        }
        changeText()
    }
    
    func changeText() {
        Time.text = userData.GetUser("time")
        check = userData.GetUser("check")
        if check == "퇴실" {
            CheckMain.text = "퇴실 상태"
            CheckAsk.text = "입실하시나요?"
            Check.setTitle("입실", for: .normal)
        } else {
            CheckMain.text = "입실 상태"
            CheckAsk.text = "퇴실하시나요?"
            Check.setTitle("퇴실", for: .normal)
        }
        CheckTime.text = check + "시간"
        Name.text = userData.GetUser("name") + "님,"
    }
    
    
}
