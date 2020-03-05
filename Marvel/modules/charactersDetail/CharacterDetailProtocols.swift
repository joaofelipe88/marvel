//
//  CharacterDetailProtocols.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 02/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

protocol CharacterDetailViewProtocol: class {
    var presenter: CharacterDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showCharacter(forChar char: Character)
    func showComics(forDetail comics: [Detail])
    func showSeries(forDetail series: [Detail])
    func setFavoriteButton(_ isFavorite: Bool)
}

protocol CharacterDetailWireframeProtocol: class {
    static func createCharacterDetailModule(forChar char: Character) -> UIViewController
}

protocol CharacterDetailPresenterProtocol: class {
    var view: CharacterDetailViewProtocol? { get set }
    var wireFrame: CharacterDetailWireframeProtocol? { get set }
    var interactor: CharacterDetailInteractorInputProtocol? { get set }
    var char: Character? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func setCharFavorite()
    func setCharUnFavorite()
}

protocol CharacterDetailInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveComicsDetail(_ comicsDetail: [Detail])
    func didRetrieveSeriesDetail(_ seriesDetail: [Detail])
    func didFailedRequest(with error: String)
}

protocol CharacterDetailInteractorInputProtocol: class {
    
    var presenter: CharacterDetailInteractorOutputProtocol? { get set }
    var remoteDatamanager: CharacterDetailRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveCharDetail(forChar char: Character)
}

protocol CharacterDetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: CharacterDetailRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveCharDetail(forChar char: Character)
}

protocol CharacterDetailRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onComicsDetailRetrieved(_ chars: [Detail])
    func onSeriesDetailRetrieved(_ chars: [Detail])
    func didFailedRequest(with error: String)
}
