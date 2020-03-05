//
//  FavoriteNavigationController.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 05/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

class FavoriteNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rootView = CharactersFavoriteWireframe.createCharactersFavoriteModule()
        self.pushViewController(rootView, animated: false)
    }
}
