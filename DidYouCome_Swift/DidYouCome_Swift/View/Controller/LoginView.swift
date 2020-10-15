//
//  LoginView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/13.
//

import UIKit
import RxSwift

class LoginViewModel: UIViewController {
    
    @IBOutlet weak var topContraintHeight: NSLayoutConstraint!
    
    @IBAction func ShowSignUp(_ sender: Any) {
        topContraintHeight.constant = 0;
        UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
        print("Click")
    }
    
    @IBAction func ShowLogin(_ sender: Any) {
        topContraintHeight.constant = 900;
        UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
        print("Click")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        topContraintHeight.constant = 900;
    }
    @IBAction func SignUp(_ sender: Any) {
        
    }
    
    @IBAction func Login(_ sender: Any) {
        
    }
}
