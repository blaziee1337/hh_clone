//
//  LogInCoordinator.swift
//  hh_clone
//
//  Created by Halil Yavuz on 02.04.2024.
//

import UIKit

class LogInCoordinator: Coordinator {
    
    weak var appCoordinator: AppCoordinator!
  
    override func start() {
        let vc = LoginViewController()
        let viewModel = LogInViewModel()
        vc.viewModel = viewModel
       viewModel.appCoordinator = self
      
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    override func finish() {
        print("AppCoordinator finish")
        finishDelegate?.coordinatorDidFinish(childCoordinators: self)
       
    }
    
    
    func goToConfirm() {
        appCoordinator.showConformation()
        
    }
    
}



