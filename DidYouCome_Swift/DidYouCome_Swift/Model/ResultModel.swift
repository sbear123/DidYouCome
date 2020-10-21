//
//  ResultModel.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/17.
//

import Foundation

struct ResultModel {
    private var result: String = ""
    
    private var type: String = ""
    
    var _result: String {
        get {
            return result
        }
        set {
            result = newValue
        }
    }
    
    var _type: String {
        get {
            return type
        }
        set {
            type = newValue
        }
    }
}
