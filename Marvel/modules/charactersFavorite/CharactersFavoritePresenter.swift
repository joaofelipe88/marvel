//
//  CharactersFavoritePresenter.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 05/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit
import RxSwift

class CharactersFavoritePresenter: CharactersFavoritePresenterProtocol {
    
    var view: CharactersFavoriteViewProtocol?
    
    private var repository: FavoriteRepository!
    private var disposeBag = DisposeBag()
    
    func fetchCharacters() {
        view?.showLoading()
        repository = FavoriteRepository()
        repository.fetch()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] charFavorites in
            guard let self = self else { return }
            self.view?.hideLoading()
            if charFavorites.count > 0 {
                self.view?.showCharacters(charFavorites)
            } else {
                self.view?.emptyView()
            }
            }, onError: { error in
                self.view?.showError(with: error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
