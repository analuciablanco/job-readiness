//
//  UnderDevelopmentView.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 21/09/22.
//

import UIKit

class UnderDevelopmentView: UIView {
    
    private let underDevImageView: UIImageView = {
        guard let image = UIImage(named: "under-dev") else { return UIImageView() }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .heavy)
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "Oops! La categoría que buscas no se encuentra disponible."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.addSubview(underDevImageView)
        self.addSubview(label)
        
        let imageSize = self.frame.size.width / 2
        
        NSLayoutConstraint.activate([
            underDevImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -80),
            underDevImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            underDevImageView.widthAnchor.constraint(equalToConstant: imageSize),
            underDevImageView.heightAnchor.constraint(equalToConstant: imageSize),
            label.topAnchor.constraint(equalTo: underDevImageView.bottomAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
}
