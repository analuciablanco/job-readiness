//
//  SearchViewController.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import UIKit

class SearchViewController: UIViewController {
    private let searchBarController: UISearchController = {
        let controller = UISearchController()
        controller.automaticallyShowsCancelButton = true
        controller.searchBar.placeholder = "Buscar en Mercado Libre"
        return controller
    }()
    
    private let viewModel: UIViewController?
    
    private let tableView = UITableView()
    
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
        
        setupTableView()
        setupSearchBar()
        constraints()
        
        var isSearchBarEmpty: Bool {
            return searchBarController.searchBar.text?.isEmpty ?? true
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(CategoryItemCell.self, forCellReuseIdentifier: "itemCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupSearchBar() {
        searchBarController.automaticallyShowsScopeBar = true
        searchBarController.searchBar.delegate = self
        navigationItem.searchController = searchBarController
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemTeal
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchString = searchBar.text else { return }
        
        let endpoint = EndpointType.category(search: searchString)
        Network.fetch(EndpointBuilder(endpoint: endpoint), type: Category.self) { data, error in
            guard let categoryData = data else { return }
            print(categoryData)
        }
    }
}
