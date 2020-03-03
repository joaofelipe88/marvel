//
//  CharacterItem.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation

struct CharacterItem: Codable {

    var name: String?
    var resourceURI: String?
    
    init(name: String, resourceURI: String) {
        self.name = name
        self.resourceURI = resourceURI
    }
}

extension CharacterItem {
    
    static func generateMock() -> CharacterItem {
        
        let item = CharacterItem(name: "All-New Guardians of the Galaxy (2017)", resourceURI: "http://gateway.marvel.com/v1/public/series/23058")
        return item
    }
}
