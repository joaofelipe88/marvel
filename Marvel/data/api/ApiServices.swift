//
//  ApiServices.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation

class ApiServices {
    
    internal let LIMIT = 20
    
    public func defaultParams() -> String {
        let timestamp = buildTimestamp()
        let hash = apiHash(timestamp: timestamp)
        return "apikey=\(ApiDefinitions.ApiKeys.publicKey.rawValue)&ts=\(timestamp)&hash=\(hash)"
    }
    
    public func apiHash(timestamp: String) -> String {
        let seed = "\(timestamp)\(ApiDefinitions.ApiKeys.privateKey.rawValue)\(ApiDefinitions.ApiKeys.publicKey.rawValue)"
        return MD5Helper.fabricate(value: seed)
    }
    
    private func buildTimestamp() -> String {
        return "\(Date().timeIntervalSince1970)"
    }
}
