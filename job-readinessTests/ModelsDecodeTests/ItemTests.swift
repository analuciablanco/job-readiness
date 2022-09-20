//
//  ItemTests.swift
//  job-readinessTests
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import XCTest
@testable import job_readiness

class ItemTests: XCTestCase {
    
    func test_categoryDecode() throws {
        if let bundlePath = Bundle.main.path(forResource: "Highlights", ofType: "json") {
            guard let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) else {
                XCTFail("jsonData fail")
                return
            }
            
            let decoder = JSONDecoder()
            let response = try decoder.decode(Item.self, from: jsonData)
            
            let item = response.content[0]
            
            XCTAssertEqual(item.id, "MLM779689485")
            XCTAssertEqual(item.position, 1)
            XCTAssertEqual(item.type, TypeEnum.item)
        } else {
            XCTFail("JSON file not found")
        }
    }
}
