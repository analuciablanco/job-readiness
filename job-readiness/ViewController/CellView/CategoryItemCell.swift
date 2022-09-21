//
//  CategoryItemCell.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 20/09/22.
//

import UIKit

class CategoryItemCell: UITableViewCell {
    
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
    private let itemImageView: UIImageView = {
        let image = UIImage(systemName: "house")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var itemTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Test"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var itemPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    private func setupView() {
//        contentView.addSubview(stackView)
        contentView.addSubview(itemTitle)
        contentView.addSubview(itemPrice)
        
        NSLayoutConstraint.activate([
            itemTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            itemImageView.topAnchor.constraint(equalTo: imageMainView.topAnchor),
//            itemImageView.bottomAnchor.constraint(equalTo: imageMainView.bottomAnchor),
//            itemImageView.heightAnchor.constraint(equalToConstant: 120),
//            itemImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

}
