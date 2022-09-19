//
//  EndpointBuilderTests.swift
//  job-readinessTests
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import XCTest
@testable import job_readiness

class EndpointBuilderTests: XCTestCase {

    func test_urlBuildWithAllParameters() {
        let endpoint = EndpointType.category(search: "usb")
        let sut = EndpointBuilder(scheme: "https",
                           host: "api.mercadolibre.com",
                           endpoint: endpoint)
        
        XCTAssertNotNil(sut)
    }
    
    func test_urlBuildWithRequiredOnly() {
        let endpoint = EndpointType.highlights(categoryId: "MLM437952")
        let sut = EndpointBuilder(endpoint: endpoint)
        
        XCTAssertNotNil(sut)
    }
    
    func test_categoryEndpoint() {
        let endpoint = EndpointType.category(search: "usb")
        let sut = EndpointBuilder(endpoint: endpoint)
        let mockURL = "https://api.mercadolibre.com/sites/MLM/domain_discovery/search?limit=1&q=usb"
        
        guard let urlString = sut.getString() as? String else {
            print(sut.getString())
            return
        }
        
        XCTAssertEqual(urlString, mockURL)
    }
    
    func test_highlightsEndpoint() {
        let endpoint = EndpointType.highlights(categoryId: "MLM437952")
        let sut = EndpointBuilder(endpoint: endpoint)
        let mockURL = "https://api.mercadolibre.com/highlights/MLM/category/MLM437952"
        
        guard let urlString = sut.getString() as? String else {
            print(sut.getString())
            return
        }
        
        XCTAssertEqual(urlString, mockURL)
    }
    
    func test_multigetEndpoint_singleItem() {
        let endpoint = EndpointType.multiget(ids: ["MLM905863486"])
        let sut = EndpointBuilder(endpoint: endpoint)
        let mockURL = "https://api.mercadolibre.com/items?ids=MLM905863486"
        
        guard let urlString = sut.getString() as? String else {
            print(sut.getString())
            return
        }
        
        XCTAssertEqual(urlString, mockURL)
    }
    
    func test_multigetEndpoint_multipleItem() {
        let endpoint = EndpointType.multiget(ids: ["MLM1355861327", "MLM905863486", "MLM854728989"])
        let sut = EndpointBuilder(endpoint: endpoint)
        let mockURL = "https://api.mercadolibre.com/items?ids=MLM1355861327,MLM905863486,MLM854728989"
        
        guard let urlString = sut.getString() as? String else {
            print(sut.getString())
            return
        }
        
        XCTAssertEqual(urlString, mockURL)
    }
}
