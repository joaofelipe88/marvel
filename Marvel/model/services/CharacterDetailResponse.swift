//
//  CharacterDetailResponse.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 03/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation

struct CharacterDetailResponse: Codable {
    var attributionText: String?
    var data: CharacterDetailData?
}

struct CharacterDetailData: Codable {
    var offset: Int?
    var limit: Int?
    var results: [Detail]?
}
