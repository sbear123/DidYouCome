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
    let server: SetServer = SetServer()
    
    func MakeUser(_ id: String, password: String, school: String, name: String) -> Bool {
        user._userid = id
        user._password = password
        user._school = school
        user._name = name
        
        result = self.SignUp(userData: user)
        if result._result == "ok" {
            return true
        }
        else {
            return false
        }
    }
    
    func SignUp(userData: UserModel) -> ResultModel {
        let param: Dictionary = ["userid": userData._userid, "password": userData._password,  "name": userData._name, "school": userData._school] // JSON 객체로 변환할 딕셔너리 준비
        let request = server.POST(api: "register.api", param: param)
        let sem = DispatchSemaphore.init(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let data = data, error == nil else { // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            let dataJson:Data? = responseString!.data(using: .utf8)
            if let dJson = dataJson{
                var dataDIctionary:[String:String]?
                dataDIctionary = try! JSONSerialization.jsonObject(with: dJson,options:[]) as! [String:String]
                if let dJsonDic = dataDIctionary{
                    print(dJsonDic)
                    if let results = dJsonDic["result"]{
                        self.result._result = results
                        print(self.result._result)
                    }
                    sem.signal()
                }
            }
        }
        task.resume()
        sem.wait()

        return result
    }
    
    func CheckSchool(school: String) -> Bool {
        var check = false
        let param: Dictionary = ["school": school] // JSON 객체로 변환할 딕셔너리 준비
        let request = server.POST(api: "checkSchool.api", param: param)
        let sem = DispatchSemaphore.init(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let data = data, error == nil else { // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            let dataJson:Data? = responseString!.data(using: .utf8)
            if let dJson = dataJson{
                var dataDIctionary:[String:String]?
                dataDIctionary = try! JSONSerialization.jsonObject(with: dJson,options:[]) as! [String:String]
                if let dJsonDic = dataDIctionary{
                    print(dJsonDic)
                    if let results = dJsonDic["result"]{
                        if results == "ok" {
                            check = true
                        }
                    }
                    sem.signal()
                }
            }
        }
        task.resume()
        sem.wait()

        return check
    }
}

