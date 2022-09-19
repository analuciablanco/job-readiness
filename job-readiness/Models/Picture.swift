//
//  Picture.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import Foundation

// MARK: - Picture
struct Picture: Decodable {
    let id: String
    let secureURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case secureURL = "secure_url"
    }
}
