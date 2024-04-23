//
//  SearchCoordinator.swift
//  hh_clone
//
//  Created by Halil Yavuz on 03.04.2024.
//

import UIKit


class SearchCoordinator: Coordinator {
    weak var appCoordinate: AppCoordinator!
    override func start() {
       let vc = SearchViewController()
//        //vc.coordinate = self
//        let vm = SearchViewModel()
//        vm.coordinate = self
//        vc.viewModel = vm
      
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
