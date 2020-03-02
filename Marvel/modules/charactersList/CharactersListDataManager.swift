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
        .subscribe(onNext: { chars in
            self.remoteRequestHandler?.onCharsRetrieved(chars)
        }, onError: { error in
            self.remoteRequestHandler?.didFailedRequest(with: error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func searchCharList(textName: String) {
        
        getCharacters(lastIndex: 0, textName: textName)
        .subscribe(onNext: { chars in
            self.remoteRequestHandler?.onCharsRetrieved(chars)
        }, onError: { error in
            self.remoteRequestHandler?.didFailedRequest(with: error.localizedDescription)
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

}
