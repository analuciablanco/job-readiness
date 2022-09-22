//
//  CustomNavigationController.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 21/09/22.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    private var customBackButtonImage: UIImage? {
        guard let image = UIImage(systemName: "arrow.backward") else { return nil }
        return image
    }
    
    private var cartImage: UIImage? {
        guard let cartImage = UIImage(systemName: "cart") else { return nil }
        return cartImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavBarItems()
    }
    
    private func setupView() {
        navigationBar.backgroundColor = UIColor.customYellow
        
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = UIColor.customYellow
        
        navigationBar.standardAppearance = appearence
        navigationBar.compactAppearance = appearence
    }
    
    private func setupNavBarItems() {
        let cartItem = UIBarButtonItem(image: cartImage,
                                       style: .plain,
                                       target: self,
                                       action: #selector(didTapCart(_:)))
        
        self.navigationItem.rightBarButtonItem = cartItem
    }
    
    @objc func didTapCart(_ sender: UIButton) {
        print("Cart button tapped")
    }
}
