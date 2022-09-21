//
//  SearchViewController.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import UIKit

class SearchViewController: UIViewController {
    private let viewModel: ViewModelable?
    
    // MARK: - Properties
    private var itemCount: Int = 0 {
        didSet {
            self.tableView.reloadData()
        }
    }
    private var itemsDetail: MultigetItemsDetail?
    
    private let searchBarController: UISearchController = {
        let controller = UISearchController()
        controller.automaticallyShowsCancelButton = true
        controller.searchBar.placeholder = "Buscar en Mercado Libre"
        return controller
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryItemCell.self, forCellReuseIdentifier: "itemCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: ViewModelable) {
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
            self.tableView.reloadData()
            return searchBarController.searchBar.text?.isEmpty ?? true
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
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
    
    private func fetchItems(for category: Category) {
        let endpoint = EndpointType.highlights(categoryId: category[0].categoryID)
        Network.fetch(EndpointBuilder(endpoint: endpoint), type: Item.self) { items, error in
            guard let itemsData = items else { return }
            
            let onlyItemType = itemsData.content.filter { item in
                item.type == .item
            }
            
            let itemsID = onlyItemType.map { item in
                item.id
            }
            
            self.fetchItemDetail(for: itemsID)
        }
        
    }
    
    private func fetchItemDetail(for itemsID: [String]) {
        let endpoint = EndpointType.multiget(ids: itemsID)
        Network.fetch(EndpointBuilder(endpoint: endpoint), type: MultigetItemsDetail.self) { itemsDetail, error in
            self.itemsDetail = itemsDetail
            
            DispatchQueue.main.async {
                self.itemCount = itemsDetail?.count ?? 0
                print("Item count:", self.itemCount)
            }
        }
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell",
                                                       for: indexPath) as? CategoryItemCell else { return UITableViewCell() }
        if itemCount != 0 {
            cell.itemTitle.text = itemsDetail?[indexPath.row].body.title
//            cell.itemPrice.text = String(describing: itemsDetail?[indexPath.row].body.price)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemViewModel = ItemDetailViewModel()
        let itemVC = ItemDetailViewController(viewModel: itemViewModel)
        guard let itemDetail = itemsDetail?[indexPath.row] else { return }
        itemVC.setupItemData(itemDetail: itemDetail)
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchString = searchBar.text else { return }
        
        let endpoint = EndpointType.category(search: searchString)
        Network.fetch(EndpointBuilder(endpoint: endpoint), type: Category.self) { data, error in
            guard let categoryData = data else { return }
            print("Categoria:", categoryData[0].categoryName)
            self.fetchItems(for: categoryData)
        }
    }
}
