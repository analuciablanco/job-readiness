//
//  ItemDetailViewController.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 21/09/22.
//

import UIKit
import Kingfisher

class ItemDetailViewController: UIViewController {
    // MARK: - Properties
    var itemDetail: ItemDetail? {
        didSet {
            guard let itemDetail = itemDetail else { return }
            let itemData = itemDetail.body
            itemTitle.text = itemData.title
            itemPrice.text = "$\(itemData.price)"
            
            guard let thumbnailUrl = URL(string: itemData.pictures?[0].secureURL ?? "") else { return }
            itemImage.kf.setImage(with: thumbnailUrl)
        }
    }
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
        label.font = .systemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let itemImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
    
    // MARK: - UI Setup
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(itemTitle)
        view.addSubview(itemImage)
        view.addSubview(itemPrice)
    }
    
    private func setupConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        let viewSafeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            itemTitle.topAnchor.constraint(equalTo: viewSafeArea.topAnchor, constant: 24),
            itemTitle.leadingAnchor.constraint(equalTo: viewSafeArea.leadingAnchor, constant: 24),
            itemTitle.trailingAnchor.constraint(equalTo: viewSafeArea.trailingAnchor, constant: -24),
            itemImage.heightAnchor.constraint(equalToConstant: screenWidth),
            itemImage.topAnchor.constraint(equalTo: itemTitle.bottomAnchor, constant: 24),
            itemImage.leadingAnchor.constraint(equalTo: viewSafeArea.leadingAnchor, constant: 24),
            itemImage.trailingAnchor.constraint(equalTo: viewSafeArea.trailingAnchor, constant: -24),
            itemPrice.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 24),
            itemPrice.leadingAnchor.constraint(equalTo: viewSafeArea.leadingAnchor, constant: 24),
            itemPrice.trailingAnchor.constraint(equalTo: viewSafeArea.trailingAnchor, constant: 24),
        ])
    }
}
