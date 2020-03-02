//
//  CharactersListInteractor.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation

class CharactersListInteractor: CharactersListInteractorInputProtocol {
    
    var presenter: CharactersListInteractorOutputProtocol?
    var remoteDatamanager: CharactersListRemoteDataManagerInputProtocol?
    
    func retrieveCharList(lastIndex: Int) {
        remoteDatamanager?.retrieveCharList(lastIndex: lastIndex)
    }
    
    func searchCharList(textName: String) {
        remoteDatamanager?.searchCharList(textName: textName)
    }
}

extension CharactersListInteractor: CharactersListRemoteDataManagerOutputProtocol {
    
    func onCharsRetrieved(_ chars: [Character]) {
        presenter?.didRetrieveChars(chars)
    }
    
    func didFailedRequest(with error: String) {
//        presenter?.onError()
    }
}
