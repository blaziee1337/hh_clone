//
//  AppCoordinator.swift
//  hh_clone
//
//  Created by Halil Yavuz on 02.04.2024.
//

import UIKit


class AppCoordinator: Coordinator {
    private let userStorage = UserStorage.shared
    override func start() {
        if userStorage.isLogin {
            showMainFlow()
        } else {
            showLogin()
        }
        
        
        print("coordinator start")

    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}

// MARK: - Navigation methods

  extension AppCoordinator {
      
    func showLogin() {
        
        let logInCoordinator = LogInCoordinator(navigationController: navigationController)
        logInCoordinator.appCoordinator = self
        addChildCoordinator(logInCoordinator)
        logInCoordinator.start()
        
    }
    
    func showConformation() {
       
        let confirmCoordinator = ConformationCoordinator(navigationController: navigationController, finishDelegate: self)
        confirmCoordinator.appCoordiantor = self
        addChildCoordinator(confirmCoordinator)
        confirmCoordinator.finishDelegate = self
        confirmCoordinator.start()
        
    }
    
    func showMainFlow() {
        
        let searchNavigationController = UINavigationController()
        let searchCoordinator = SearchCoordinator(navigationController: searchNavigationController)
        
        searchNavigationController.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(named: "search"), tag: 0)
        searchCoordinator.finishDelegate = self
        searchCoordinator.start()
       
    
        let favoriteNavigationController = UINavigationController()
        let favoriteCoordinator = FavoriteCoordinator(navigationController: favoriteNavigationController)
        favoriteNavigationController.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(named: "favouritesfalse"), tag: 1)
        favoriteCoordinator.finishDelegate = self
        favoriteCoordinator.start()
        
        let responsesNavigationController = UINavigationController()
        let responsesCoordinator = ResponsesCoordinator(navigationController: responsesNavigationController)
        responsesNavigationController.tabBarItem = UITabBarItem(title: "Отклики", image: UIImage(named: "email"), tag: 2)
        responsesCoordinator.finishDelegate = self
        responsesCoordinator.start()
        
        let messagesNavigationController = UINavigationController()
        let messagesCoordinator = MessagesCoordinator(navigationController: messagesNavigationController)
        messagesNavigationController.tabBarItem = UITabBarItem(title: "Сообщения", image: UIImage(named: "message"), tag: 3)
        messagesCoordinator.finishDelegate = self
        messagesCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profile"), tag: 4)
        profileCoordinator.finishDelegate = self
        profileCoordinator.start()
        
        addChildCoordinator(searchCoordinator)
        addChildCoordinator(favoriteCoordinator)
        addChildCoordinator(responsesCoordinator)
        addChildCoordinator(messagesCoordinator)
        addChildCoordinator(profileCoordinator)
        
        let tabBarControllers = [searchNavigationController, favoriteNavigationController, responsesNavigationController, messagesNavigationController, profileNavigationController]
       let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
        navigationController.pushViewController(tabBarController, animated: true)

    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinators: CoordinatorProtocol) {
        removeChildCoordinator(childCoordinators)
       
    }
}
