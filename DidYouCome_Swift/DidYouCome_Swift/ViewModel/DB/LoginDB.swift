//
//  LoginDB.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/14.
//

import Foundation

class LoginDB {
    var result: ResultModel = ResultModel()
    let db: DB = DB()
    
    func Login(userData: UserModel) -> ResultModel{
        let param: Dictionary = ["userid": userData._userid, "password": userData._password] // JSON 객체로 변환할 딕셔너리 준비
        let request = db.POST(api: "login.api", param: param)
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
                        if let names = dJsonDic["name"]{
                            self.result._name = names as! String
                        }
                        if let times = dJsonDic["time"]{
                            self.result._time = times as! String
                        }
                        if let checks = dJsonDic["check"]{
                            self.result._check = checks as! Int
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
}
