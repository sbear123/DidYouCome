//
//  DB.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/17.
//

import Foundation

class DB {
    let sUrl = "http://localhost:8081/DidYouComeServer/"
    
    func POST(api: String, param: Dictionary<String, Any>) -> URLRequest {
        
        let url = URL(string: sUrl+api)
        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        return request
    }
}
