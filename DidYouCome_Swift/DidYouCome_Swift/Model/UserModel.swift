//
//  UserModel.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/14.
//

import Foundation

class UserModel: NSObject {
    private var _userid: String!
    private var _password: String!
    private var _school: String!
    private var _name: String!
    private var _type: String!
    
    private var _check: String!
    private var _time: String!
    
    var userid: String {
        get {
            return _userid
        }
        set {
            _userid = newValue
        }
    }
    
    var password: String {
        get {
            return _password
        }
        set {
            _password = newValue
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
    
    var check: String {
        get {
            return _check
        }
        set {
            _check = newValue
        }
    }
    
    var time: String {
        get {
            return _time
        }
        set {
            _time = newValue
        }
    }
    
}
