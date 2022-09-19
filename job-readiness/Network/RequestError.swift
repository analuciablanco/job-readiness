//
//  RequestError.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import Foundation

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
