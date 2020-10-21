//
//  UserModel.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/14.
//

import Foundation

struct UserModel {
    private var userid: String = ""
    private var password: String = ""
    private var school: String = ""
    private var name: String = ""
    private var type: String = ""
    
    private var check: String = ""
    private var time: String = ""
    
    var _userid: String {
        get {
            return userid
        }
        set(id) {
            userid = id
        }
    }
    
    var _password: String {
        get {
            return password
        }
        set {
            password = newValue
        }
    }
    
    var _school: String {
        get {
            return school
        }
        set {
            school = newValue
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
    
    var _check: String {
        get {
            return check
        }
        set {
            check = newValue
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
    
}
