//
//  ResultModel.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/17.
//

import Foundation

class ResultModel: NSObject {
    private var _result: String!
    
    private var _school: String!
    private var _name: String!
    private var _type: String!
    
    var result: String {
        get {
            return _result
        }
        set {
            _result = newValue
        }
    }
    
    var school: String {
        get {
            return _school
        }
        set {
            _school = newValue
        }
    }
    
    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    var type: String {
        get {
            return _type
        }
        set {
            _type = newValue
        }
    }
}
