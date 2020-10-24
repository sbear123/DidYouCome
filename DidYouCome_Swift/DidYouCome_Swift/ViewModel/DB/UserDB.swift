//
//  UserDB.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/24.
//

import Foundation

class UserDB {
    let db: DB = DB()
    
    func AutoLogin(userid: String) {
        let param: Dictionary = ["userid": userid] // JSON 객체로 변환할 딕셔너리 준비
        let request = db.POST(api: "getUser.api", param: param)
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

