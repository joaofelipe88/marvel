//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 02/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    var presenter: CharacterDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension CharacterDetailViewController: CharacterDetailViewProtocol {
    
    func showCharDetail(forChar char: Character) {
        
    }
}
