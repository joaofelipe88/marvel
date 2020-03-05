//
//  CharacterDetailPresenter.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 02/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit
import RxSwift

class CharacterDetailPresenter: CharacterDetailPresenterProtocol {
    
    var view: CharacterDetailViewProtocol?
    var wireFrame: CharacterDetailWireframeProtocol?
    var interactor: CharacterDetailInteractorInputProtocol?
    var char: Character?
    
    private var repository: FavoriteRepository!
    private var disposeBag = DisposeBag()
    
    func viewDidLoad() {
        view?.showCharacter(forChar: char!)
        interactor?.retrieveCharDetail(forChar: char!)
        
        repository = FavoriteRepository()
        isFavorite()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {[weak self] isFavorite in
            guard let self = self else { return }
            self.view?.setFavoriteButton(isFavorite)
        }).disposed(by: disposeBag)
    }
    
    func setCharFavorite() {
        favorite()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.view?.setFavoriteButton(true)
        }).disposed(by: disposeBag)
    }
    
    func setCharUnFavorite() {
        unFavorite()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.view?.setFavoriteButton(false)
        }).disposed(by: disposeBag)
    }
    
    func isFavorite() -> Observable<Bool> {
        return repository.find(character: self.char ?? Character())
        .map { !$0.isEmpty }
    }
    
    func favorite() -> Observable<Bool> {
        return repository.insert(character: self.char ?? Character())
    }
    
    func unFavorite() -> Observable<Bool> {
        return repository.delete(character: self.char ?? Character())
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
