//
//  FavoriteCoordinator.swift
//  hh_clone
//
//  Created by Halil Yavuz on 03.04.2024.
//

import UIKit

class FavoriteCoordinator: Coordinator {
    override func start() {
        let vc = FavouriteVacancyViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
