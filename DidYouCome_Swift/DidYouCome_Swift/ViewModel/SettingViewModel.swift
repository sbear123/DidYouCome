//
//  SettingViewModel.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/25.
//

import Foundation

class SettingViewModel{
    var user: UserViewModel = UserViewModel()
    var result: Bool = false
    let server: SetServer = SetServer()
    
    func ChangeName(_ name: String) -> Bool {
        let param: Dictionary = ["userid": user.GetUser("userid"), "name": name] // JSON 객체로 변환할 딕셔너리 준비
        return getResult(param, api: "name.api")
    }
    
    func ChangePw(_ Pw: String) -> Bool {
        let param: Dictionary = ["userid": user.GetUser("userid"), "password": Pw] // JSON 객체로 변환할 딕셔너리 준비
        return getResult(param, api: "chpw.api")
    }
    
    func CheckPw(Pw: String) -> Bool {
        let param: Dictionary = ["userid": user.GetUser("userid"), "password": Pw] // JSON 객체로 변환할 딕셔너리 준비
        return getResult(param, api: "checkpw.api")
    }
    
    func ChangeSchool(_ school: String) -> Bool {
        let param: Dictionary = ["userid": user.GetUser("userid"), "school": school] // JSON 객체로 변환할 딕셔너리 준비
        return getResult(param, api: "school.api")
    }
    
    func getResult(_ param: Dictionary<String, String>, api: String)-> Bool{
        let request = server.POST(api: api, param: param)
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
                        print(results)
                        if results == "ok"{
                            self.result = true
                        } else {
                            self.result = false
                        }
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
