//
//  SignUpViewModel.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/20.
//

import Foundation

class SignUpViewModel{
    var user: UserModel = UserModel()
    var result: ResultModel = ResultModel()
    let db: SignUpDB = SignUpDB	()
    
    func MakeUser(_ id: String, password: String, school: String, name: String) -> Bool {
        user._userid = id
        user._password = password
        user._school = school
        user._name = name
        
        result = db.SignUp(userData: user)
        if result._result == "ok" {
            return true
        }
        else {
            return false
        }
    }
}

