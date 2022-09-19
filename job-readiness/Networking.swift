//
//  Networking.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 17/09/22.
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

struct Network {
    
}

extension Network: Networking { }

// MARK: - Networking
protocol Networking {
    func fetch<T: Decodable>(_ endpoint: EndpointBuilder,
                             type: T.Type,
                             completion: @escaping (T?, RequestError?) -> Void)
}

extension Networking {
    func fetch<T: Decodable>(_ endpoint: EndpointBuilder,
                             type: T.Type,
                             completion: @escaping (T?, RequestError?) -> Void) {
        
        guard let safeUrl: URL = endpoint.getUrl() as? URL else {
            completion(nil, RequestError.urlNil)
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: safeUrl) { data, _, error in
            
            guard let safeData = data else {
                DispatchQueue.main.async { completion(nil, RequestError.noData) }
                print(String(describing: error))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(T.self, from: safeData)
                DispatchQueue.main.async { completion(response, nil) }
            } catch {
                DispatchQueue.main.async { completion(nil, RequestError.decodingResponseError) }
                print(String(describing: error))
            }
        }
        task.resume()
    }
}

// MARK: - EndpointBuilder

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

// MARK: - URL builder
struct EndpointBuilder {
    var urlComponents = URLComponents()
    
    init(scheme: String = "https",
         host: String = "api.mercadolibre.com",
         endpoint: EndpointType) {
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = endpoint.getPath(for: endpoint)
        urlComponents.queryItems = endpoint.getQuerys(for: endpoint)
    }
    
    func getString() -> Any {
        guard let safeString = urlComponents.string else {
            return RequestError.stringUrlNil
        }
        return safeString
    }
    
    func getUrl() -> Any {
        guard let safeUrl = urlComponents.url else {
            return RequestError.urlNil
        }
        return safeUrl
    }
}

// MARK: - Request Error
enum RequestError: Error {
    case stringUrlNil
    case urlNil
    case invalidURL
    case noData
    case decodingResponseError
    case noImage
    case forbidden              // Status code 403
    case notFound               // Status code 404
    case conflict               // Status code 409
    case internalServerError    // Status code 500
}
