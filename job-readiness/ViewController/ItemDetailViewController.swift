//
//  ItemDetailViewController.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 21/09/22.
//

import UIKit

class ItemDetailViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: ItemDetailViewModel?
    
    // MARK: - UI Properties
    private let itemTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let itemPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Life Cycle
    init(viewModel: ViewModelable) {
        self.viewModel = viewModel as? ItemDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
    }
    
    // MARK: - Item Data Setup
    func setupItemData(itemDetail: ItemDetail) {
        let itemData = itemDetail.body
        itemTitle.text = itemData.title
    }
    
    // MARK: - UI Setup
    private func setupView() {
        view.backgroundColor = .cyan
        view.addSubview(itemTitle)
    }
    
    private func setupConstraints() {
        let viewSafeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            itemTitle.topAnchor.constraint(equalTo: viewSafeArea.topAnchor, constant: 24),
            itemTitle.leadingAnchor.constraint(equalTo: viewSafeArea.leadingAnchor, constant: 24),
            itemTitle.trailingAnchor.constraint(equalTo: viewSafeArea.trailingAnchor, constant: -24)
        ])
    }
}
