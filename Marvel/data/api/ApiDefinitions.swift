//
//  ApiDefinitions.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation

struct ApiDefinitions {
    
    // MARK: - The BASE URL
    
    static let baseUrl = "https://gateway.marvel.com:443/v1/public/"
    
    // MARK: - Possible Endpoints
    
    enum Endpoint: String {
        case characters = "characters"
    }
    
    // MARK: - Possible Http Methods
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    // MARK: - APIKeys
    
    enum ApiKeys: String {
        case publicKey = "24ee0aeded0cc8ba4b26f8617278fa39"
        case privateKey = "5f34e81bc5e61b93adbdf0b83d882a20341bd8b9"
    }
}
