//
//  Category.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import Foundation

// MARK: - Category
typealias Category = [CategoryElement]

struct CategoryElement: Decodable {
    let categoryID: String
    let categoryName: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
    }
}
