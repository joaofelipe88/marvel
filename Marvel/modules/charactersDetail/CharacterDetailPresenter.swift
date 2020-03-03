//
//  CharacterDetailPresenter.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 02/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

class CharacterDetailPresenter: CharacterDetailPresenterProtocol {
    
    var view: CharacterDetailViewProtocol?
    var wireFrame: CharacterDetailWireframeProtocol?
    var interactor: CharacterDetailInteractorInputProtocol?
    var char: Character?
    
    func viewDidLoad() {
        view?.showCharacter(forChar: char!)
        interactor?.retrieveCharDetail(forChar: char!)
    }
    
}

extension CharacterDetailPresenter: CharacterDetailInteractorOutputProtocol {
    
    func didRetrieveComicsDetail(_ comicsDetail: [Detail]) {
        view?.showComics(forDetail: comicsDetail)
    }
    
    func didRetrieveSeriesDetail(_ seriesDetail: [Detail]) {
        view?.showSeries(forDetail: seriesDetail)
    }
    
    func didFailedRequest(with error: String) {
        
    }
}
