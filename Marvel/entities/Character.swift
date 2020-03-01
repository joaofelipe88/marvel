//
//  Character.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation

struct Character: Codable {
    
    let characterId: Int?
    let name: String?
    let description: String?
    var resourceURI: String?
    let thumbURL: CharacterThumbnail?
    var comics: CharacterDetail?
    var series: CharacterDetail?
}

struct CharacterThumbnail: Codable {
    var path: String?
    var imgExtension: String?
    
    private enum CodingKeys: String, CodingKey {
        case path
        case imgExtension = "extension"
    }
}
