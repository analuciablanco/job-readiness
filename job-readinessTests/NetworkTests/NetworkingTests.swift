//
//  NetworkingTests.swift
//  job-readinessTests
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import XCTest
@testable import job_readiness

class NetworkingTests: XCTestCase {
    
    func test_fetchAndDecoder_ForCategory() throws {
        let endpoint = EndpointBuilder(endpoint: EndpointType.category(search: "iphone"))
        
        let promise = expectation(description: "Completion handler")
        print(endpoint.getUrl())
        
        Network.fetch(endpoint, type: Category.self) { data, error in
            guard let safeData = data else {
                XCTFail("Error: \(String(describing: error))")
                return
            }
            XCTAssertEqual(safeData[0].categoryID, "MLM1055")
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func test_fetchAndDecoder_ForHighlights() throws {
        let endpoint = EndpointBuilder(endpoint: EndpointType.highlights(categoryId: "MLM1166"))
        
        let promise = expectation(description: "Completion handler")
        print(endpoint.getUrl())
        
        Network.fetch(endpoint, type: Item.self) { data, error in
            guard let safeData = data else {
                XCTFail("Error: \(String(describing: error))")
                return
            }
            XCTAssertEqual(safeData.content[0].id, "MLM1333420605")
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func test_fetchAndDecoder_ForItemDetail() throws {
        let endpoint = EndpointBuilder(endpoint: EndpointType.multiget(ids: ["MLM1333420605"]))
        
        let promise = expectation(description: "Completion handler")
        print(endpoint.getUrl())
        
        Network.fetch(endpoint, type: MultigetItemsDetail.self) { data, error in
            guard let safeData = data else {
                XCTFail("Error: \(String(describing: error))")
                return
            }
            XCTAssertEqual(safeData[0].body.title, "Juguete De Peluches De Cactus Bailando Cantando Imitaciones")
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }
    
}
