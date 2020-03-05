//
//  CharactersFavoriteProtocols.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 05/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

protocol CharactersFavoriteViewProtocol {
    
    var presenter: CharactersFavoritePresenterProtocol! { get set }

    // PRESENTER -> VIEW
    func showError(with message: String)
    func showLoading()
    func hideLoading()
    func emptyView()
    func showCharacters(_ chars: [Character])
}

protocol CharactersFavoriteWireFrameProtocol: class {
    static func createCharactersFavoriteModule() -> UIViewController
}

protocol CharactersFavoritePresenterProtocol: class {
    
    var view: CharactersFavoriteViewProtocol? { get set }
    
    // VIEW -> PRESENTER
    func fetchCharacters()
}
