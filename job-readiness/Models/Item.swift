//
//  Item.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import Foundation

// MARK: - Item
struct Item: Decodable {
    let content: [Content]
}

// MARK: - Content
struct Content: Decodable {
    let id: String
    let position: Int
    let type: TypeEnum
}

enum TypeEnum: String, Decodable {
    case item = "ITEM"
    case product = "PRODUCT"
}

// MARK: - Token Error
struct ItemError: Decodable {
    let error: String
    let message: String
    let status: Int
}
