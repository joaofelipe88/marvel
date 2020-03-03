//
//  CharacterDetailInteractor.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 03/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

class CharacterDetailInteractor: CharacterDetailInteractorInputProtocol {
    
    var presenter: CharacterDetailInteractorOutputProtocol?
    var remoteDatamanager: CharacterDetailRemoteDataManagerInputProtocol?
    
    func retrieveCharDetail(forChar char: Character) {
        remoteDatamanager?.retrieveCharDetail(forChar: char)
    }
}

extension CharacterDetailInteractor: CharacterDetailRemoteDataManagerOutputProtocol {
    
    func onComicsDetailRetrieved(_ chars: [Detail]) {
        presenter?.didRetrieveComicsDetail(chars)
    }
    
    func onSeriesDetailRetrieved(_ chars: [Detail]) {
        presenter?.didRetrieveSeriesDetail(chars)
    }
    
    func didFailedRequest(with error: String) {
    }
}
