//
//  UserViewModel.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/24.
//

import UIKit

class UserViewModel{
    
    func GetUser(_ keyName: String) -> String {
        return UserDefaults.standard.string(forKey: keyName)!
    }
    
    func SetUser(key:String, keyName: String) {
        UserDefaults.standard.set(key, forKey: keyName)
    }
}

