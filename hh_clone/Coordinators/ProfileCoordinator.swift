//
//  ProfileCoordinator.swift
//  hh_clone
//
//  Created by Halil Yavuz on 03.04.2024.
//

import UIKit

class ProfileCoordinator: Coordinator {
    override func start() {
        let vc = ViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
