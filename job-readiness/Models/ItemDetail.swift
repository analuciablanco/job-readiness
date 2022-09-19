//
//  ItemDetail.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import Foundation

// MARK: - Item Detail
struct ItemDetail: Decodable {
    let code: Int
    let body: Body
}

// MARK: - Body
struct Body: Decodable {
    let id: Int
    let title: String
    let sellerID: Int
    let categoryID: String
    let price: Double
    let originalPrice: Int
    let currencyID: String
    let initialQuantity: Int
    let availableQuantity: Int
    let soldQuantity: Int
    let condition: String
    let secureThumbnail: String
    let pictures: [Picture]
    let sellerAddress: SellerAddress
    let status: String
    let warranty: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case sellerID = "seller_id"
        case categoryID = "category_id"
        case price
        case originalPrice = "original_price"
        case currencyID = "currency_id"
        case initialQuantity = "initial_quantity"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case condition
        case secureThumbnail = "secure_thumbnail"
        case pictures
        case sellerAddress = "seller_address"
        case status
        case warranty
    }
}

// MARK: - Seller Address
struct SellerAddress: Decodable {
    let city: AddressInfo
    let state: AddressInfo
    let country: AddressInfo
}

// MARK: - Address Info
struct AddressInfo: Decodable {
    let id: String
    let name: String
}
