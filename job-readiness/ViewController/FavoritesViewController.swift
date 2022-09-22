//
//  FavoritesViewController.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 22/09/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    // MARK: - Properties
    private var itemCount: Int = 0 {
        didSet {
            self.tableView.reloadData()
            self.setupViewOnResponse()
        }
    }
    
    private var itemsDetail: MultigetItemsDetail?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryItemCell.self, forCellReuseIdentifier: "itemCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        let itemsID = fetchItemsID()
        fetchItemDetail(for: itemsID)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let itemsID = fetchItemsID()
        fetchItemDetail(for: itemsID)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        tableView.reloadData()
        let itemsID = fetchItemsID()
        fetchItemDetail(for: itemsID)
    }
    
    private func setupViewOnResponse() {
        if itemCount == 0 {
            tableView.removeFromSuperview()
            view = UnderDevelopmentView()

        } else {
            view = UIView()
            setupTableView()
            constraints()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchItemsID() -> [String] {
        let defaultsKeys = UserDefaults.standard.dictionaryRepresentation().keys
        
        let filteredKeys: [String] = defaultsKeys.filter { key in
            let keyString = key.codingKey.stringValue
            if keyString.contains("MLM") {
                return true
            } else {
                return false
            }
        }
        
        return filteredKeys
        
    }
    
    private func fetchItemDetail(for itemsID: [String]) {
        let endpoint = EndpointType.multiget(ids: itemsID)
        Network.fetch(EndpointBuilder(endpoint: endpoint), type: MultigetItemsDetail.self) { itemsDetail, error in
            self.itemsDetail = itemsDetail
            
            DispatchQueue.main.async {
                self.itemCount = itemsDetail?.count ?? 0
            }
        }
    }
    
    private func validateIfItsFavorite(_ id: String) -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: id)
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell",
                                                       for: indexPath) as? CategoryItemCell else { return UITableViewCell() }
        if itemCount != 0 {
            guard let itemsDetail = itemsDetail else { return UITableViewCell() }
            cell.itemDetail = itemsDetail[indexPath.row]
            cell.isFavorite = validateIfItsFavorite(itemsDetail[indexPath.row].body.id)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemViewModel = ItemDetailViewModel()
        let itemVC = ItemDetailViewController(viewModel: itemViewModel)
        guard let itemDetail = itemsDetail?[indexPath.row] else { return }
        itemVC.itemDetail = itemDetail
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
}
