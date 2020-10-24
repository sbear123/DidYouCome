//
//  SetServer.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/17.
//

import Foundation

class SetServer {
    let sUrl = "http://localhost:8081/DidYouComeServer/"
    
    func POST(api: String, param: Dictionary<String, String>) -> URLRequest {
        let apiUrl = sUrl + api
        let url = URL(string: apiUrl)
        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        print(apiUrl)
        print(param)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        return request
    }
}
