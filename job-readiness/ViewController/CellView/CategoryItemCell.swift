//
//  CategoryItemCell.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 20/09/22.
//

import UIKit

class CategoryItemCell: UITableViewCell {
    var itemDetail: ItemDetail? {
        didSet {
            guard let itemDetail = itemDetail else { return }
            itemTitle.text = itemDetail.body.title
            itemPrice.text = "$\(itemDetail.body.price)"
            
            guard let thumbnailUrl = URL(string: itemDetail.body.secureThumbnail ?? "") else { return }
            itemImageView.kf.setImage(with: thumbnailUrl)
        }
    }
    
    // MARK: - Stack View
    private lazy var imageMainView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.addSubview(itemImageView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.addSubview(itemTitle)
        view.addSubview(itemPrice)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.addSubview(imageMainView)
        sv.addSubview(infoView)
        sv.axis = .horizontal
        sv.alignment = .leading
        sv.distribution = .fillProportionally
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // MARK: - Properties
    let itemImageView: UIImageView = {
        let image = UIImage(systemName: "house")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var itemTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Test"
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var itemPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    private func setupView() {
//        contentView.addSubview(stackView)
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemTitle)
        contentView.addSubview(itemPrice)
    }
    
    private func setupConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        let viewSafeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            itemImageView.widthAnchor.constraint(equalToConstant: screenWidth / 3),
            itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor),
            itemImageView.topAnchor.constraint(equalTo: viewSafeArea.topAnchor, constant: 12),
            itemImageView.leadingAnchor.constraint(equalTo: viewSafeArea.leadingAnchor, constant: 12),
            itemImageView.bottomAnchor.constraint(equalTo: viewSafeArea.bottomAnchor, constant: 12),
            itemTitle.topAnchor.constraint(equalTo: itemImageView.topAnchor),
            itemTitle.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            itemTitle.trailingAnchor.constraint(equalTo: viewSafeArea.trailingAnchor, constant: -12),
            itemPrice.topAnchor.constraint(equalTo: itemTitle.bottomAnchor, constant: 12),
            itemPrice.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            itemPrice.trailingAnchor.constraint(equalTo: viewSafeArea.trailingAnchor, constant: -12)
        ])
    }

}
