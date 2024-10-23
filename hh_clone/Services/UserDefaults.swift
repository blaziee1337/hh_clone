//
//  UserDefaults.swift
//  hh_clone
//
//  Created by Halil Yavuz on 23.10.2024.
//

import Foundation

class IsLoginFlag {
    static let shared = IsLoginFlag()
    
    var isLogin: Bool {
        get { UserDefaults.standard.bool(forKey: "isLogin")}
        set { UserDefaults.standard.set(newValue, forKey: "isLogin")}
    }
}
