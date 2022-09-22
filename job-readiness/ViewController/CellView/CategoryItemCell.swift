//
//  CategoryItemCell.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 20/09/22.
//

import UIKit

class CategoryItemCell: UITableViewCell {
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
            itemTitle.text = itemDetail.body.title
            itemPrice.text = "$\(itemDetail.body.price)"
            
            guard let address = itemDetail.body.sellerAddress else { return }
            let city = address.city.name
            let state = address.state.name
            let country = address.country.name
            
            itemAddress.text = city + ", " + state + ", " + country
            
            guard let thumbnailUrl = URL(string: itemDetail.body.secureThumbnail ?? "") else { return }
            itemImageView.kf.setImage(with: thumbnailUrl)
        }
    }
    
    // MARK: - UI Properties
    private let itemImageView: UIImageView = {
        let image = UIImage(systemName: "house")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var isFavoriteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapOnFavoriteButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var itemTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.text = "Test"
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var itemPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var itemAddress: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Stack View
    private lazy var infoStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.spacing = 12
        sv.addArrangedSubview(itemTitle)
        sv.addArrangedSubview(itemPrice)
        sv.addArrangedSubview(itemAddress)
        return sv
    }()
    
    // MARK: - Life Cycle
    override func prepareForReuse() {
        if let itemID = itemDetail?.body.id {
            setFavoriteStatus(for: itemID)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    @objc private func didTapOnFavoriteButton(_ sender: UIButton!) {
        if let itemID = itemDetail?.body.id {
            switchFavoriteStatus(for: itemID)
            print("isFavorite value:", isFavorite)
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
            defaults.removeObject(forKey: id)
            defaults.synchronize()
            print("removed:", id)
            isFavorite = false
        } else {
            defaults.set(true, forKey: id)
            defaults.synchronize()
            print(id)
            isFavorite = true
        }
    }
    
    // MARK: - Setups
    private func setupView() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(infoStackView)
        contentView.addSubview(isFavoriteButton)
    }
    
    private func setupConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        let viewSafeArea = contentView.safeAreaLayoutGuide
        
        isFavoriteButton.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            itemImageView.widthAnchor.constraint(equalToConstant: screenWidth / 3),
            itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor),
            
            itemImageView.topAnchor.constraint(equalTo: viewSafeArea.topAnchor, constant: 12),
            itemImageView.bottomAnchor.constraint(equalTo: viewSafeArea.bottomAnchor, constant: -12),
            itemImageView.leadingAnchor.constraint(equalTo: viewSafeArea.leadingAnchor, constant: 12),
            
            isFavoriteButton.widthAnchor.constraint(equalTo: itemImageView.widthAnchor, multiplier: 0.25),
            isFavoriteButton.heightAnchor.constraint(equalTo: itemImageView.widthAnchor, multiplier: 0.25),
            
            isFavoriteButton.topAnchor.constraint(equalTo: itemImageView.topAnchor, constant: 12),
            isFavoriteButton.trailingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: -12),
            
            infoStackView.topAnchor.constraint(equalTo: viewSafeArea.topAnchor, constant: 12),
            infoStackView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            infoStackView.trailingAnchor.constraint(equalTo: viewSafeArea.trailingAnchor, constant: -12),
        ])
    }

}
