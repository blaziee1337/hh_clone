//
//  UserStorage.swift
//  hh_clone
//
//  Created by Halil Yavuz on 23.04.2024.
//

import Foundation

class UserStorage {
    static let shared = UserStorage()
    
    var isLogin: Bool {
        get { UserDefaults.standard.bool(forKey: "isLogin")}
        set { UserDefaults.standard.set(newValue, forKey: "isLogin")}
    }
}
