//
//  EndpointBuilder.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import Foundation

// MARK: - Endpoint builder
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
    
    func getString() -> Result<String, RequestError> {
        guard let safeString = urlComponents.string else {
            return .failure(RequestError.stringUrlNil)
        }
        
        return .success(safeString)
    }
    
    func getUrl() -> Result<URL, RequestError> {
        guard let safeUrl = urlComponents.url else {
            return .failure(RequestError.urlNil)
        }
        return .success(safeUrl)
    }
}
