//
//  LoginDB.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/14.
//

import Foundation

class LoginDB {
    let user: UserModel = UserModel()
    let result: ResultModel = ResultModel()
    let db: DB = DB()
    
    func SignUp(userData: UserModel) -> Void {
        let param: Dictionary = ["userid": user.userid, "password": user.password,  "name": user.name, "school": user.school] // JSON 객체로 변환할 딕셔너리 준비
        let request = db.POST(api: "signup.api", param: param)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
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
                        self.result.result = results
                        print(self.result.result)
                    }
                }
            }
        }
        task.resume()
    }
    
    func Login(userData: UserModel) -> Void{
        let param: Dictionary = ["userid": user.userid, "password": user.password] // JSON 객체로 변환할 딕셔너리 준비
        let request = db.POST(api: "login.api", param: param)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
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
                        self.result.result = results
                        print(self.result.result)
                        if let types = dJsonDic["types"]{
                            self.result.type = types
                        }
                        if let names = dJsonDic["name"]{
                            self.result.name = names
                        }
                        if let schools = dJsonDic["school"]{
                            self.result.school = schools
                        }
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func getResult() -> ResultModel {
        return result
    }
}
