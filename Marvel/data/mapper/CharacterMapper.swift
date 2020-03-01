//
//  CharactereMapper.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation

class CharacterMapper {
    
    func mapCharacters(response: CharacterResponse) -> [Character] {
        guard let characters = response.data?.results else { return [Character]() }
        return characters
    }
}
