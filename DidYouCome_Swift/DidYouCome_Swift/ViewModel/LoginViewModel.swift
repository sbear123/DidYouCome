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
    
    func CheckNull(_ text: String) -> String {
        if (text == "") {
            return "입력되지 않은 것이 있습니다. 입력을 다시 확인해주세요."
        }
        else{
            return ""
        }
    }
    
    func MakeUser(_ id: String, password: String, school: String, name: String) -> Bool {
        user.userid = id
        user.password = password
        user.school = school
        user.name = name
        
        db.SignUp(userData: user)
        result = db.getResult()
        if result.result == "ok" {
            return true
        }
        else {
            return false
        }
    }
    
    func GetUser(_ id: String, password: String) -> String {
        user.userid = id
        user.password = password
        
        db.Login(userData: user)
        result = db.getResult()
        if result.result == "ok" {
            return result.type
        }
        else {
            return result.result
        }
    }
}
