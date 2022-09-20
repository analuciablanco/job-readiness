//
//  CategoryTests.swift
//  job-readinessTests
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import XCTest
@testable import job_readiness

class CategoryTests: XCTestCase {

    func test_categoryDecode() throws {
        do {
            if let bundlePath = Bundle.main.path(forResource: "Category", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                
                print(bundlePath)
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(Category.self, from: jsonData)
                
                XCTAssertEqual(response[0].categoryID, "MLM191198")
            }
        } catch {
            XCTFail("Error at decoding Category")
        }
    }
}
