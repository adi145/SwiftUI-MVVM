//
//  SaveUser.swift
//  SwiftUIMVVM
//
//  Created by Adinarayana on 06/07/20.
//  Copyright © 2020 Adinarayana Machavarapu. All rights reserved.
//

import Foundation

class SaveUser{
    
    static let login_username = "login_username"
    static let login_user_id = "login_user_id"
    
    class func save(key: String, value:String) {
       UserDefaults.standard.set(value, forKey: key)
       UserDefaults.standard.synchronize()
    }
    class func get(key: String) -> String{
        guard let userName = UserDefaults.standard.value(forKey: key) as? String else {
            return ""
        }
        return userName
    }
    class func getUserId()-> String {
        guard let userId = UserDefaults.standard.value(forKey: login_user_id) as? String else {
            return ""
        }
        return userId
    }
    class func remove(key: String){
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}
