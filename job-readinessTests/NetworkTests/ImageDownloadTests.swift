//
//  ImageDownloadTests.swift
//  job-readinessTests
//
//  Created by Ana Lucia Blanco Cervantes on 21/09/22.
//

import XCTest
import Kingfisher
@testable import job_readiness

class ImageDownloadTests: XCTestCase {
    
    func test_ImageDownload_FromUrl_usingKF() {
        let url = URL(string: "https://http2.mlstatic.com/D_718136-MLM51051955029_082022-I.jpg")
        let imageView = UIImageView()
        
        imageView.kf.setImage(with: url) { response in
            switch response {
            case .success(let value):
                XCTAssertNotNil(value.image)
            case .failure(let error):
                XCTFail(String(describing: error))
            }
        }
    }
    
    func test_ImageDownload_FromJSON_usingKF() throws {
        
        if let bundlePath = Bundle.main.path(forResource: "Multiget", ofType: "json") {
            guard let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) else {
                XCTFail("jsonData fail")
                return
            }
            
            let decoder = JSONDecoder()
            let response = try decoder.decode(MultigetItemsDetail.self, from: jsonData)
            
            let imageUrlString = response[0].body.secureThumbnail ?? ""
            let url = URL(string: imageUrlString)
            let imageView = UIImageView()
            
            imageView.kf.setImage(with: url) { response in
                switch response {
                case .success(let value):
                    XCTAssertNotNil(value.image)
                case .failure(let error):
                    XCTFail(String(describing: error))
                }
            }
            
        } else {
            XCTFail("JSON file not found")
        }
    }
}
