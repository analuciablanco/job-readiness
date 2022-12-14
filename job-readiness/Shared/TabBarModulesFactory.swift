//
//  TabBarModulesFactory.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import Foundation
import UIKit

enum Module {
    case home
    case favorites
    case purchases
    case notifications
    case more
}

struct TabBarModulesFactory {
    func makeTabBarNavController(for module: Module) -> UINavigationController {
        let title: String
        let tabIcon: UIImage
        let tabPosition: Int
        
        let viewModel: ViewModelable
        let rootVC: UIViewController
        
        switch module {
        case .home:
            title = "Inicio"
            tabIcon = UIImage(systemName: "house") ?? UIImage()
            tabPosition = 0
            viewModel = SearchViewModel()
            rootVC = SearchViewController(viewModel: viewModel)
        case .favorites:
            title = "Favoritos"
            tabIcon = UIImage(systemName: "heart") ?? UIImage()
            tabPosition = 1
//            viewModel = UnderDevelopmentViewController()
            rootVC = FavoritesViewController()
            rootVC.title = title
        case .purchases:
            title = "Mis Compras"
            tabIcon = UIImage(systemName: "bag") ?? UIImage()
            tabPosition = 2
//            viewModel = UnderDevelopmentViewController()
            rootVC = UnderDevelopmentViewController()
            rootVC.title = title
        case .notifications:
            title = "Notificaciones"
            tabIcon = UIImage(systemName: "bell") ?? UIImage()
            tabPosition = 3
//            viewModel = UnderDevelopmentViewController()
            rootVC = UnderDevelopmentViewController()
            rootVC.title = title
        case .more:
            title = "Más"
            tabIcon = UIImage(systemName: "list.bullet") ?? UIImage()
            tabPosition = 4
//            viewModel = UnderDevelopmentViewController()
            rootVC = UnderDevelopmentViewController()
            rootVC.title = title
        }
        
        rootVC.tabBarItem = UITabBarItem(title: title,
                                         image: tabIcon,
                                         tag: tabPosition)
        
        let navBarController = CustomNavigationController(rootViewController: rootVC)
        
        return navBarController
    }
}
