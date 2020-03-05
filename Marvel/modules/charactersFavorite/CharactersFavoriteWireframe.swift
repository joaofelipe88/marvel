//
//  CharactersFavoriteWireframe.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 05/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

class CharactersFavoriteWireframe: CharactersFavoriteWireFrameProtocol {
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createCharactersFavoriteModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "CharactersFavoriteView")
        if let view = viewController as? CharactersFavoriteViewController {
            let presenter: CharactersFavoritePresenterProtocol = CharactersFavoritePresenter()
            
            view.presenter = presenter
            presenter.view = view
            
            return viewController
        }
        return UIViewController()

    }
}
