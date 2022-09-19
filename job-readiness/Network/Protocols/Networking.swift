//
//  Networking.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 17/09/22.
//

import Foundation

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
        
        guard let safeUrl: URL = endpoint.getUrl() as? URL else {
            completion(nil, RequestError.urlNil)
            return
        }
        
        var request = URLRequest(url: safeUrl)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.value)", forHTTPHeaderField: "Authorization")
        
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
    }
}
