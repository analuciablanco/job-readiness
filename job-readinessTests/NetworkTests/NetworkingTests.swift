//
//  NetworkingTests.swift
//  job-readinessTests
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import XCTest
@testable import job_readiness

class NetworkingTests: XCTestCase {
    let endpoint = EndpointBuilder(endpoint: EndpointType.category(search: "usb"))
    
    func test_fetchAndDecoder() throws {
        let promise = expectation(description: "Completion handler")
        print(endpoint.getUrl())
        
        Network.fetch(endpoint, type: Category.self) { data, error in
            guard let safeData = data else {
                XCTFail("Error: \(String(describing: error))")
                return
            }
            
            XCTAssertEqual(safeData[0].categoryID, "MLM191198")
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }
    
}
