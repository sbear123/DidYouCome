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
    let server: SetServer = SetServer()
    
    func GetUser(_ id: String, password: String) -> String {
        user._userid = id
        user._password = password
        
        result = self.Login(userData: user)
        print(result)
        if result._result == "ok" {
            return result._type
        }
        else {
            return result._result
        }
    }
    
    func Login(userData: UserModel) -> ResultModel{
        let param: Dictionary = ["userid": userData._userid, "password": userData._password] // JSON 객체로 변환할 딕셔너리 준비
        let request = server.POST(api: "login.api", param: param)
        let sem = DispatchSemaphore.init(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            let dataJson:Data? = responseString!.data(using: .utf8)
            if let dJson = dataJson{
                var dataDIctionary:[String:Any]?
                dataDIctionary = try! JSONSerialization.jsonObject(with: dJson,options:[]) as! [String:Any]
                if let dJsonDic = dataDIctionary{
                    if let results = dJsonDic["result"]{
                        self.result._result = results as! String
                        if let types = dJsonDic["type"]{
                            self.result._type = types as! String
                        }
                    }
                    print(dJsonDic)
                    sem.signal()
                }
            }
        }
        
        task.resume()
        sem.wait()

        return result
    }
    
    func AutoLogin(userid: String) {
        let param: Dictionary = ["userid": userid] // JSON 객체로 변환할 딕셔너리 준비
        let request = server.POST(api: "getUser.api", param: param)
        let sem = DispatchSemaphore.init(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let data = data, error == nil else {
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            let dataJson:Data? = responseString!.data(using: .utf8)
            if let dJson = dataJson{
                var dataDIctionary:[String:Any]?
                dataDIctionary = try! JSONSerialization.jsonObject(with: dJson,options:[]) as! [String:Any]
                if let dJsonDic = dataDIctionary{
                    print(dJsonDic)
                    if let id = dJsonDic["userid"]{
                        UserDefaults.standard.set(id, forKey: "userid")
                    }
                    if let name = dJsonDic["name"]{
                        UserDefaults.standard.set(name, forKey: "name")
                    }
                    if let school = dJsonDic["school"]{
                        UserDefaults.standard.set(school, forKey: "school")
                    }
                    if let check = dJsonDic["check"]{
                        UserDefaults.standard.set(check, forKey: "check")
                    }
                    if let time = dJsonDic["time"]{
                        UserDefaults.standard.set(time, forKey: "time")
                    }
                    if let type = dJsonDic["type"]{
                        UserDefaults.standard.set(type, forKey: "type")
                    }
                    print(dJsonDic)
                    sem.signal()
                }
            }
        }
        
        task.resume()
        sem.wait()
    }
}
