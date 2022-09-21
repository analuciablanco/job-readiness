//
//  UnderDevelopmentViewController.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 20/09/22.
//

import UIKit

class UnderDevelopmentViewController: UIViewController {
    
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
        label.text = "Oops! El contenido no se encuentra disponible."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(underDevImageView)
        view.addSubview(label)
        
        let imageSize = view.frame.size.width / 2
        
        NSLayoutConstraint.activate([
            underDevImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            underDevImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            underDevImageView.widthAnchor.constraint(equalToConstant: imageSize),
            underDevImageView.heightAnchor.constraint(equalToConstant: imageSize),
            label.topAnchor.constraint(equalTo: underDevImageView.bottomAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}
