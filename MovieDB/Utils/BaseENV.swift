//
//  BaseENV.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 12.03.2023.
//

import Foundation

class BaseENV {
    
    let dict: NSDictionary
    
    init(resourceName: String) {
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file '\(resourceName)' plist.")
        }
        self.dict = plist
    }
}

protocol APIKeyable {
    var API_KEY: String { get }
}

class ProdENV: BaseENV, APIKeyable {
    init() {
        super.init(resourceName: "PROD-Keys")
    }
    
    var API_KEY: String {
        dict.object(forKey: "API_KEY") as? String ?? ""
    }
}

var ENV: APIKeyable {
    return ProdENV()
}
