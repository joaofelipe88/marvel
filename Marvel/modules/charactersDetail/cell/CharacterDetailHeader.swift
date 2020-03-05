//
//  CharacterDetailHeader.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 04/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

class CharacterDetailHeader: UICollectionReusableView {

    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupHeader(_ text: String) {
        self.headerLabel.text = text
    }
    
}
