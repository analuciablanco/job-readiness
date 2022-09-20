//
//  ItemDetailTests.swift
//  job-readinessTests
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import XCTest
@testable import job_readiness

class ItemDetailTests: XCTestCase {
    func test_categoryDecode() throws {
        if let bundlePath = Bundle.main.path(forResource: "Multiget", ofType: "json") {
            guard let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) else {
                XCTFail("jsonData fail")
                return
            }
            
            let decoder = JSONDecoder()
            let response = try decoder.decode(MultigetItemsDetail.self, from: jsonData)
            
            let multigetItemsCount = response.count
            let firstItemCode = response[0].code
            let firstItemBody = response[0].body
            
            XCTAssertEqual(multigetItemsCount, 2)
            XCTAssertEqual(firstItemCode, 200)
            XCTAssertEqual(firstItemBody.id, "MLM1355861327")
            
        } else {
            XCTFail("JSON file not found")
        }
    }
}
