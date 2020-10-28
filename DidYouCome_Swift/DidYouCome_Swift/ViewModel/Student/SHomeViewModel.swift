//
//  SHomeViewModel.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/28.
//

import Foundation

class SHomeViewModel{
    var user: UserModel = UserModel()
    var result: ResultModel = ResultModel()
    let server: SetServer = SetServer()
    let UserData: UserViewModel = UserViewModel()
    
    func CheckIn() {
        let param: Dictionary = ["userid": UserData.GetUser("userid")] // JSON 객체로 변환할 딕셔너리 준비
        let request = server.POST(api: "checkin.api", param: param)
        let sem = DispatchSemaphore.init(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let data = data, error == nil else { // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            let dataJson:Data? = responseString!.data(using: .utf8)
            if let dJson = dataJson{
                var dataDIctionary:[String:Any]?
                dataDIctionary = try! JSONSerialization.jsonObject(with: dJson,options:[]) as! [String:Any]
                if let dJsonDic = dataDIctionary{
                    print(dJsonDic)
                    if let time = dJsonDic["time"]{
                        self.UserData.SetUser(key: time as! String, keyName: "time")
                    }
                    if let check = dJsonDic["check"]{
                        self.UserData.SetUser(key: check as! String, keyName: "check")
                    }
                    sem.signal()
                }
            }
        }
        task.resume()
        sem.wait()

        return
    }
    
    func CheckOut() {
        let param: Dictionary = ["userid": UserData.GetUser("userid")] // JSON 객체로 변환할 딕셔너리 준비
        let request = server.POST(api: "checkout.api", param: param)
        let sem = DispatchSemaphore.init(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let data = data, error == nil else { // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            let dataJson:Data? = responseString!.data(using: .utf8)
            if let dJson = dataJson{
                var dataDIctionary:[String:Any]?
                dataDIctionary = try! JSONSerialization.jsonObject(with: dJson,options:[]) as! [String:Any]
                if let dJsonDic = dataDIctionary{
                    print(dJsonDic)
                    if let time = dJsonDic["time"]{
                        UserDefaults.standard.set(time, forKey: "time")
                        print(time)
                    }
                    if let check = dJsonDic["check"]{
                        UserDefaults.standard.set(check, forKey: "check")
                        print(check)
                    }
                    sem.signal()
                }
            }
        }
        task.resume()
        sem.wait()

        return
    }
}
