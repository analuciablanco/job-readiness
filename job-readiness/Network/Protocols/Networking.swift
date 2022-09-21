//
//  Networking.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 17/09/22.
//

import Foundation
import UIKit
import Kingfisher

// MARK: - Networking
protocol Networking {
    static func fetch<T: Decodable>(_ endpoint: EndpointBuilder,
                             type: T.Type,
                             completion: @escaping (T?, RequestError?) -> Void)
}

extension Networking {
    static func fetch<T: Decodable>(_ endpoint: EndpointBuilder,
                             type: T.Type,
                             completion: @escaping (T?, RequestError?) -> Void) {
        
        let url = endpoint.getUrl()
        
        switch url {
        case .success(let safeUrl):
            var request = URLRequest(url: safeUrl)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Token.value.rawValue)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
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
            
        case .failure(let error):
            print(String(describing: error))
            break
        }
    }
}
