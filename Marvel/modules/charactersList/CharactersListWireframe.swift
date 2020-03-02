//
//  CharactersListWireframe.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

class CharactersListWireframe: CharactersListWireFrameProtocol {
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createCharactersListModule() -> UIViewController {
        let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "MarvelTabbarController")
        if let view = tabBarController.children.first?.children.first as? CharactersListViewController {
            let presenter: CharactersListPresenterProtocol & CharactersListInteractorOutputProtocol = CharactersListPresenter()
            let interactor: CharactersListInteractorInputProtocol & CharactersListRemoteDataManagerOutputProtocol = CharactersListInteractor()
            let remoteDataManager: CharactersListRemoteDataManagerInputProtocol = CharactersListDataManager()
            let wireFrame: CharactersListWireFrameProtocol = CharactersListWireframe()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return tabBarController
        }
        return UIViewController()

    }
    
    func presentCharactersListScreen(from view: CharactersListViewControllerProtocol, forChars chars: Character) {
        
    }
}
