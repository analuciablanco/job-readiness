//
//  CategoryItemCell.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 20/09/22.
//

import UIKit

class CategoryItemCell: UITableViewCell {
    private let itemImageView: UIImageView = {
        let image = UIImage(systemName: "house")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let itemTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let itemPrice: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .purple
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(itemImageView)
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            itemImageView.heightAnchor.constraint(equalToConstant: 120),
            itemImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

}
