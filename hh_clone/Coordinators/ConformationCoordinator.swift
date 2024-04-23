//
//  LogInCodeCoordinator.swift
//  hh_clone
//
//  Created by Halil Yavuz on 03.04.2024.
//

import UIKit

class ConformationCoordinator: Coordinator {
    
    weak var appCoordiantor: AppCoordinator!
    let userStorage = UserStorage.shared
    override func start() {
        let vc = ConformationView()
        let navigationController = navigationController 
        vc.coordinate = self
        navigationController.pushViewController(vc, animated: true)
      //  navigationController.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
    
    func showMainFlow() {
        userStorage.isLogin = true
        appCoordiantor.showMainFlow()
        
    }
}
