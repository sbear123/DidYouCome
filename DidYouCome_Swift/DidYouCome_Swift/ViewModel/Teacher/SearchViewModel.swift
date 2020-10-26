//
//  SearchViewModel.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/26.
//

import Foundation

class SearchViewModel{
    var student = [[String: Any]]()
    let server: SetServer = SetServer()
    let UserData: UserViewModel = UserViewModel()
    
    func Search(keword: String) -> [[String: Any]] {
        let param: Dictionary = ["userid": UserData.GetUser("userid"), "name": keword] // JSON 객체로 변환할 딕셔너리 준비
        let request = server.POST(api: "search.api", param: param)
        let sem = DispatchSemaphore.init(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let data = data, error == nil else { // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            let dataJson:Data? = responseString!.data(using: .utf8)
            if let dJson = dataJson{
                var dataDIctionary:[[String:Any]]?
                dataDIctionary = try! JSONSerialization.jsonObject(with: dJson,options:[]) as! [[String:Any]]
                if let dJsonDic = dataDIctionary{
                    self.student = dJsonDic
                }
                sem.signal()
            }
        }
        task.resume()
        sem.wait()
        
        return student
    }
    
    func GetStudents() -> [[String: Any]] {
        let param: Dictionary = ["userid": UserData.GetUser("userid")] // JSON 객체로 변환할 딕셔너리 준비
        let request = server.POST(api: "chstudent.api", param: param)
        let sem = DispatchSemaphore.init(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let data = data, error == nil else { // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            let dataJson:Data? = responseString!.data(using: .utf8)
            if let dJson = dataJson{
                var dataDIctionary:[[String:Any]]?
                dataDIctionary = try! JSONSerialization.jsonObject(with: dJson,options:[]) as! [[String:Any]]
                if let dJsonDic = dataDIctionary{
                    self.student = dJsonDic
                }
                sem.signal()
            }
        }
        task.resume()
        sem.wait()
        
        return student
    }
}
