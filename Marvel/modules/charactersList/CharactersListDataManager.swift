//
//  CharactersListDataManager.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation
import RxSwift

class CharactersListDataManager: ApiServices, CharactersListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: CharactersListRemoteDataManagerOutputProtocol?
    let disposeBag = DisposeBag()
    
    func retrieveCharList(lastIndex: Int) {
        
        getCharacters(lastIndex: lastIndex)
        .subscribe(onNext: { (chars) in
            self.remoteRequestHandler?.onCharsRetrieved(chars)
        }).disposed(by: disposeBag)
    }
    
    func searchCharList(textName: String) {
        
        getCharacters(lastIndex: 0, textName: textName)
        .subscribe(onNext: { (chars) in
            self.remoteRequestHandler?.onCharsRetrieved(chars)
        }).disposed(by: disposeBag)
    }
    
    func getCharacters(lastIndex: Int, textName: String? = nil) -> Observable<[Character]> {
        
        var endpoint = "\(ApiDefinitions.Endpoint.characters)?\(defaultParams())&limit=\(LIMIT)&offset=\(lastIndex)"
        if let string = textName {
            endpoint = "\(ApiDefinitions.Endpoint.characters)?\(defaultParams())&limit=\(LIMIT)&nameStartsWith=\(string)"
        }
        
        return ApiRequest<CharacterResponse>()
            .requestObject(urlString: "\(ApiDefinitions.baseUrl)\(endpoint)")
            .map { CharacterMapper().mapCharacters(response: $0) }
    }
        
    func searchCharacters(searchString: String?, start: Int, count: Int, completion: @escaping (Result<[Character]>) -> Void) {
        
        let base = ApiDefinitions.baseUrl
        let endpoint = ApiDefinitions.Endpoint.self
        let urlRequest = base + endpoint.characters.rawValue
        
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
