//
//  EndpointType.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import Foundation

// MARK: - Endpoint Path & Querys builder
enum EndpointType {
    case category(search: String)
    case highlights(categoryId: String)
    case multiget(ids: [String])
    
    func getPath(for type: EndpointType) -> String {
        switch type {
        case .category:
            return "/sites/MLM/domain_discovery/search"
        case .highlights(let categoryId):
            return "/highlights/MLM/category/\(categoryId)"
        case .multiget:
            return "/items"
        }
    }
    
    func getQuerys(for type: EndpointType) -> [URLQueryItem]? {
        switch type {
        case .category(let search):
            let queryItems = [URLQueryItem(name: "limit", value: "1"),
                              URLQueryItem(name: "q", value: search)]
            return queryItems
        case .highlights:
            return nil
        case .multiget(let ids):
            let joined = ids.joined(separator: ",")
            let queryItems = [URLQueryItem(name: "ids", value: joined)]
            return queryItems
        }
    }
}
