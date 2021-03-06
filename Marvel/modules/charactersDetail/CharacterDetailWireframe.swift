//
//  CharacterDetailWireframe.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 02/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

class CharacterDetailWireframe: CharacterDetailWireframeProtocol {
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createCharacterDetailModule(forChar char: Character) -> UIViewController {
        
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "CharacterDetailController")
        viewController.title = char.name
        
        if let view = viewController as? CharacterDetailViewController {
            let presenter: CharacterDetailPresenterProtocol & CharacterDetailInteractorOutputProtocol = CharacterDetailPresenter()
            let interactor: CharacterDetailInteractorInputProtocol & CharacterDetailRemoteDataManagerOutputProtocol = CharacterDetailInteractor()
            let remoteDataManager: CharacterDetailRemoteDataManagerInputProtocol = CharacterDetailDataManager()
            let wireFrame: CharacterDetailWireframeProtocol = CharacterDetailWireframe()

            view.presenter = presenter
            presenter.view = view
            presenter.char = char
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor

            return viewController
        }
        return UIViewController()

    }
}
