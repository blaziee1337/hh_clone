//
//  Coordinator.swift
//  hh_clone
//
//  Created by Halil Yavuz on 02.04.2024.
//

import UIKit


protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func start()
    func finish()
}

extension CoordinatorProtocol {
    func addChildCoordinator(_ childCoordinator: CoordinatorProtocol) {
        childCoordinators.append(childCoordinator)
    }
    func removeChildCoordinator(_ childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinators: CoordinatorProtocol)
}

protocol TabBarCoordinator: AnyObject, CoordinatorProtocol {
    var tabBarController: UITabBarController? { get set }
}


class Coordinator: CoordinatorProtocol {
    var childCoordinators : [CoordinatorProtocol]
    var navigationController: UINavigationController
    var finishDelegate: CoordinatorFinishDelegate?
    
    init(childCoordinators: [CoordinatorProtocol] = [CoordinatorProtocol](), navigationController: UINavigationController, finishDelegate: CoordinatorFinishDelegate? = nil) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
        self.finishDelegate = finishDelegate
        configNavController()
    }
    
    deinit {
        print("deinit ")
        childCoordinators.forEach{ $0.finishDelegate = nil }
        childCoordinators.removeAll()
    }
    
    private func configNavController() {
        navigationController.navigationBar.barStyle = .black
        navigationController.setNavigationBarHidden(true, animated: true)
//        navigationController.isNavigationBarHidden = true
        
    }
    
    func start() {
        print("start")
    }
    
    func finish() {
        print("finish")
    }
    
    
}
