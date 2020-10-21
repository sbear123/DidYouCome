//
//  SignUpDB.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/20.
//

import Foundation

class SignUpDB {
    var result: ResultModel = ResultModel()
    let db: DB = DB()
    
    func SignUp(userData: UserModel) -> ResultModel {
        let param: Dictionary = ["userid": userData._userid, "password": userData._password,  "name": userData._name, "school": userData._school] // JSON 객체로 변환할 딕셔너리 준비
        let request = db.POST(api: "register.api", param: param)
        let sem = DispatchSemaphore.init(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let data = data, error == nil else { // check for fundamental networking error
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
}

