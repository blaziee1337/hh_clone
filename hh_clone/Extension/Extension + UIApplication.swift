//
//  Extension + UIApplication.swift
//  hh_clone
//
//  Created by Halil Yavuz on 21.10.2024.
//

import UIKit

//MARK: - Background for status bar

extension UIApplication {
    
    var keyWin: UIWindow? {
        UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
    }
    
    public var statusBarRect: CGRect? {
        keyWin?.windowScene?.statusBarManager?.statusBarFrame
    }
    var statusBarUIView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 38_482_458_385
            if let statusBar = keyWin?.viewWithTag(tag) {
                return statusBar
            } else {
                let v = UIView()
                v.backgroundColor = .red
                v.frame = statusBarRect ?? .zero
                v.tag = tag
                keyWin?.addSubview(v)
                return v
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
}
