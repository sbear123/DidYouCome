//
//  ResultModel.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/17.
//

import Foundation

struct ResultModel {
    private var result: String = ""
    
    private var time: String = ""
    private var name: String = ""
    private var type: String = ""
    private var check: Int = 0
    
    var _result: String {
        get {
            return result
        }
        set {
            result = newValue
        }
    }
    
    var _time: String {
        get {
            return time
        }
        set {
            time = newValue
        }
    }
    
    var _name: String {
        get {
            return name
        }
        set {
            name = newValue
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
    
    var _check: Int {
        get {
            return check
        }
        set {
            check = newValue
        }
    }
}
