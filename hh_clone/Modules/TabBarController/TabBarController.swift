//
//  TabBarController.swift
//  hh_clone
//
//  Created by Halil Yavuz on 22.10.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
    }
    
    private func setupTabs() {
        let dataParser = DataParser()
        let coreDataManager = CoreDataManager()
        let viewModel = VacanciesViewModel(dataParser: dataParser, coreDataManager: coreDataManager)
        let searchVc = createNav(title: "Поиск", image: UIImage(named: "search"), vc: VacanciesView(viewModel: viewModel))
        let favoriteVc = createNav(title: "Избранное", image: UIImage(named: "favouritesfalse"), vc: FavoriteVacanciesView(viewModel: viewModel))
        let responsesVc = createNav(title: "Отклики", image: UIImage(named: "emailIcon"), vc: ResponsesView())
        let messagesVc = createNav(title: "Сообщения", image: UIImage(named: "message"), vc: MessagesView())
        let profileVc = createNav(title: "Профиль", image: UIImage(named: "profile"), vc: ProfileView())
        
        setViewControllers([searchVc,favoriteVc,responsesVc, messagesVc, profileVc], animated: true)
        
        tabBar.tintColor = .systemBlue
        tabBar.barTintColor = .black
        
    }
    
    private func createNav(title: String, image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.title = title
        nav.tabBarItem.image = image
        return nav
    }
    
}
