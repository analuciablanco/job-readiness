//
//  Coordinator.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import UIKit

protocol MainCoordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var window: UIWindow { get set }
    
    func start()
}

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
