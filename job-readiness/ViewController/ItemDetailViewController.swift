//
//  ItemDetailViewController.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 21/09/22.
//

import UIKit

class ItemDetailViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: ViewModelable?
    
    // MARK: - UI Properties
    private let itemTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let itemPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(viewModel: ViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
    }
    
}
