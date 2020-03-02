//
//  CharacterDetailProtocols.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 02/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

protocol CharacterDetailViewProtocol: class {
    var presenter: CharacterDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showCharDetail(forChar char: Character)
}

protocol CharacterDetailWireframeProtocol: class {
    static func createCharacterDetailModule(forChar char: Character) -> UIViewController
}

protocol CharacterDetailPresenterProtocol: class {
    var view: CharacterDetailViewProtocol? { get set }
    var wireFrame: CharacterDetailWireframeProtocol? { get set }
    var char: Character? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}
