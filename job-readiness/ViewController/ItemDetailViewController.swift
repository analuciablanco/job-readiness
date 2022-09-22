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
    var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                isFavoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                isFavoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            }
            
        }
    }
    
    var itemDetail: ItemDetail? {
        didSet {
            guard let itemDetail = itemDetail else { return }
            let itemData = itemDetail.body
            itemTitle.text = itemData.title
            itemPrice.text = "$\(itemData.price) MXN"
            
            guard let address = itemDetail.body.sellerAddress else { return }
            let city = address.city.name
            let state = address.state.name
            let country = address.country.name
            
            itemAddress.text = city + ", " + state + ", " + country
            
            guard let thumbnailUrl = URL(string: itemData.pictures?[0].secureURL ?? "") else { return }
            itemImage.kf.setImage(with: thumbnailUrl)
        }
    }
    
    private let viewModel: ItemDetailViewModel?
    
    // MARK: - UI Properties
    private let itemTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
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
    
    private lazy var isFavoriteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapOnFavoriteButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var itemAddress: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        if let itemID = itemDetail?.body.id {
            setFavoriteStatus(for: itemID)
        }
    }
    
    // MARK: - Methods
    @objc private func didTapOnFavoriteButton(_ sender: UIButton!) {
        if let itemID = itemDetail?.body.id {
            switchFavoriteStatus(for: itemID)
        }
    }
    
    private func setFavoriteStatus(for id: String) {
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: id) {
            isFavorite = true
        } else {
            isFavorite = false
        }
    }
    
    private func switchFavoriteStatus(for id: String) {
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: id) {
            isFavorite = false
            defaults.removeObject(forKey: id)
            defaults.synchronize()
        } else {
            isFavorite = true
            defaults.set(true, forKey: id)
            defaults.synchronize()
        }
    }
    
    // MARK: - UI Setup
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(itemTitle)
        view.addSubview(itemImage)
        view.addSubview(itemPrice)
        view.addSubview(isFavoriteButton)
        view.addSubview(itemAddress)
    }
    
    private func setupConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        let viewSafeArea = view.safeAreaLayoutGuide
        
        isFavoriteButton.clipsToBounds = true
        
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
            isFavoriteButton.widthAnchor.constraint(equalTo: itemImage.widthAnchor, multiplier: 0.15),
            isFavoriteButton.heightAnchor.constraint(equalTo: itemImage.widthAnchor, multiplier: 0.15),
            isFavoriteButton.topAnchor.constraint(equalTo: itemImage.topAnchor, constant: 12),
            isFavoriteButton.trailingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: -12),
            itemAddress.topAnchor.constraint(equalTo: itemPrice.bottomAnchor, constant: 24),
            itemAddress.leadingAnchor.constraint(equalTo: viewSafeArea.leadingAnchor, constant: 24),
            itemAddress.trailingAnchor.constraint(equalTo: viewSafeArea.trailingAnchor, constant: -24)
        ])
    }
}
