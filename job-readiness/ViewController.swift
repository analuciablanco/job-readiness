//
//  ViewController.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import UIKit

class ViewController: UIViewController {
    private let searchBarController: UISearchController = {
        let controller = UISearchController()
        controller.automaticallyShowsCancelButton = true
        controller.searchBar.placeholder = "Buscar"
        return controller
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .customYellow
        button.setTitle("Test", for: .normal)
        return button
    }()
    
    private let viewModel: UIViewController?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: UIViewController) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupSearchBar()
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)
        
        constraints()
        
        var isSearchBarEmpty: Bool {
            return searchBarController.searchBar.text?.isEmpty ?? true
        }
    }
    
    private func setupSearchBar() {
        searchBarController.automaticallyShowsScopeBar = true
        searchBarController.searchBar.delegate = self
        navigationItem.searchController = searchBarController
    }
    
    private func constraints() {
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemTeal
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchString = searchBar.text else { return }
        
    }
}
