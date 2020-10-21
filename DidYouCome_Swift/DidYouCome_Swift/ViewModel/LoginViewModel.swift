//
//  LoginViewModel.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/14.
//

import Foundation

class LoginViewModel{
    var user: UserModel = UserModel()
    var result: ResultModel = ResultModel()
    let db: LoginDB = LoginDB()
    
    func GetUser(_ id: String, password: String) -> String {
        user._userid = id
        user._password = password
        
        result = db.Login(userData: user)
        print(result)
        if result._result == "ok" {
            return result._type
        }
        else {
            return result._result
        }
    }
}
