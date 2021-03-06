//
//  CharactersListProtocols.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

protocol CharactersListViewControllerProtocol: class {
    
    var presenter: CharactersListPresenterProtocol! { get set }
    
    // PRESENTER -> VIEW
    func showError(with message: String)
    func showLoading()
    func hideLoading()
    func emptyView()
    func loadCharacters(_ chars: [Character])
}

protocol CharactersListWireFrameProtocol: class {
    static func createCharactersListModule() -> UIViewController
    // PRESENTER -> WIREFRAME
    func presentCharactersListScreen(from view: CharactersListViewControllerProtocol, forChar char: Character)
}

protocol CharactersListPresenterProtocol: class {
    var view: CharactersListViewControllerProtocol? { get set }
    var interactor: CharactersListInteractorInputProtocol? { get set }
    var wireFrame: CharactersListWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func fetchCharacters(pullRefresh: Bool, lastIndex: Int)
    func searchCharList(textName: String)
    func showCharacterDetail(forChar char: Character)
}

protocol CharactersListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveChars(_ chars: [Character])
    func didFailedRequest(with error: String)
}

protocol CharactersListInteractorInputProtocol: class {
    var presenter: CharactersListInteractorOutputProtocol? { get set }
    var remoteDatamanager: CharactersListRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveCharList(lastIndex: Int)
    func searchCharList(textName: String)
}

protocol CharactersListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: CharactersListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveCharList(lastIndex: Int)
    func searchCharList(textName: String)
}

protocol CharactersListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onCharsRetrieved(_ chars: [Character])
    func didFailedRequest(with error: String)
}
