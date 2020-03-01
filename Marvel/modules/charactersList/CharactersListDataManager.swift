//
//  CharactersListDataManager.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation

class CharactersListDataManager {
    
    func getHeroes(start: Int, count: Int, completion: @escaping (Result<[Character]>) -> Void) {
           
            searchHeroes(searchString: nil, start: start, count: count) {
                
                response in
                
                completion(response)
            }
        }
        
        func searchHeroes(searchString: String?, start: Int, count: Int, completion: @escaping (Result<[Character]>) -> Void) {
            
            let base = ApiDefinitions.Base.self
            let endpoint = ApiDefinitions.Endpoint.self
            let urlRequest = base.home.rawValue + endpoint.characters.rawValue
            
            var parameters: [String: Any] = [:]
            parameters["limit"] = count
            parameters["offset"] = start
            
            if let searchString = searchString {
                parameters["nameStartsWith"] = searchString
            }
            
    //        Gateway.shared.request(endpointString, method: .get, parameters: parameters) {
    //
    //            response in
    //
    //            guard response.isSuccess else {
    //                completion(Result.failure(response.error!))
    //                return
    //            }
    //
    //            guard let value = response.value as? [String: Any],
    //                let data = value["data"] as? [String: Any],
    //                let heroesPayload = data["results"] as? [[String: Any]] else {
    //                completion(Result.failure(GatewayError.MalformedResponse))
    //                return
    //            }
    //
    //            var heroes: [Hero] = []
    //            for eachHeroPayload in heroesPayload {
    //                if let hero = try? HeroMapper.mapFromSource(payload: eachHeroPayload) {
    //                    heroes.append(hero)
    //                }
    //            }
    //
    //            completion(Result.success(heroes))
    //        }
        }

}
