//
//  CharacterDetail.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation

struct CharacterDetail: Codable {

    var available: Int?
    var collectionURI: String?
    var items: [CharacterItem]?
}
