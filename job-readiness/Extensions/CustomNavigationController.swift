//
//  CustomNavigationController.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 20/09/22.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        navigationBar.backgroundColor = UIColor.customYellow
        
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = UIColor.customYellow
        
        navigationBar.standardAppearance = appearence
        navigationBar.compactAppearance = appearence
    }
}
