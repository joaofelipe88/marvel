//
//  CharacterResponse.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation

struct CharacterResponse: Codable {
    var attributionText: String?
    var data: CharacterData?
}

struct CharacterData: Codable {
    var offset: Int?
    var limit: Int?
    var results: [Character]?
}
