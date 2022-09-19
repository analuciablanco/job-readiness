//
//  ViewController.swift
//  job-readiness
//
//  Created by Ana Lucia Blanco Cervantes on 19/09/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = readLocalFile(forName: "category")!
        parse(jsonData: data)
    }


    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(Category.self,
                                                       from: jsonData)
            
            print("CategoryID:", decodedData[0].categoryID)
            print("Category name:", decodedData[0].categoryName)
            print("===================================")
        } catch {
            print("decode error")
        }
    }
}

