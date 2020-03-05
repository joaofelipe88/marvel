//
//  Character.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation

struct Character: Codable {
    
    var id: Int?
    var name: String?
    var description: String?
    var resourceURI: String?
    var thumbnail: CharacterThumbnail?
    var comics: CharacterDetail?
    var series: CharacterDetail?
    
    init() {}
    
    init(id: Int, name: String, description: String, resourceURI: String) {
        self.id = id
        self.name = name
        self.description = description
        self.resourceURI = resourceURI
    }
}

struct CharacterThumbnail: Codable {
    var path: String?
    var imgExtension: String?
    
    private enum CodingKeys: String, CodingKey {
        case path
        case imgExtension = "extension"
    }
    
    init() {}
    
    init(path: String, imgExtension: String) {
        self.path = path
        self.imgExtension = imgExtension
    }
}

extension Character {

    static func generateMock() -> Character {
        let char = Character(id: 1,
                             name: "Adam Warlock",
                             description: "Adam Warlock is an artificially created human who was born in a cocoon at a scientific complex called The Beehive.",
                             resourceURI: "http://gateway.marvel.com/v1/public/characters/1010354")
        return char
    }
}
