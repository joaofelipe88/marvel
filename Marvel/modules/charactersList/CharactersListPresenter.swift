//
//  CharactersListPresenter.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

class CharactersListPresenter: CharactersListPresenterProtocol {
    
    var view: CharactersListViewControllerProtocol?
    var interactor: CharactersListInteractorInputProtocol?
    var wireFrame: CharactersListWireFrameProtocol?
    
    func fetchCharacters(pullRefresh: Bool, lastIndex: Int) {
        if !pullRefresh {
            view?.showLoading()
        }
        interactor?.retrieveCharList(lastIndex: lastIndex)
    }
}

extension CharactersListPresenter: CharactersListInteractorOutputProtocol {
    
    func didRetrieveChars(_ chars: [Character]) {
        view?.hideLoading()
        view?.loadCharacters(chars)
//        wireFrame?.presentCharactersListScreen(from: view!, forChars: chars)
    }
    
    func didFailedRequest(with error: String) {
        view?.hideLoading()
        view?.showError(with: error)
    }
}
