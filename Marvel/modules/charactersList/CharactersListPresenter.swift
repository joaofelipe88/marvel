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
    
    func searchCharList(textName: String) {
        view?.showLoading()
        interactor?.searchCharList(textName: textName)
    }
    
    func showCharacterDetail(forChar char: Character) {
        wireFrame?.presentCharactersListScreen(from: view!, forChar: char)
    }
}

extension CharactersListPresenter: CharactersListInteractorOutputProtocol {
    
    func didRetrieveChars(_ chars: [Character]) {
        
        view?.hideLoading()
        
        if chars.count > 0 {
            view?.loadCharacters(chars)
        } else {
            view?.emptyView()
        }
    }
    
    func didFailedRequest(with error: String) {
        view?.hideLoading()
        view?.showError(with: error)
    }
}
