//
//  AppCoordinator.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import UIKit

final class AppCoordinator: MainCoordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var window: UIWindow
    
    let tabBarController = UITabBarController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        setupTabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        setupStatusBarColor()
    }
    
    func setupStatusBarColor() {
        if #available(iOS 13, *)
        {
            let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor = UIColor.customYellow
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        }
    }
    
    func setupTabBarController() {
        let factory = TabBarModulesFactory()
        
        tabBarController.setViewControllers([
            factory.makeTabBarNavController(for: .home),
            factory.makeTabBarNavController(for: .favorites),
            factory.makeTabBarNavController(for: .purchases),
            factory.makeTabBarNavController(for: .notifications),
            factory.makeTabBarNavController(for: .more)
        ], animated: true)
    }
}
