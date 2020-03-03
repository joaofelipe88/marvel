//
//  CharacterDetailMapper.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 03/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation

class CharacterDetailMapper {
    
    func mapCharacterDetail(response: CharacterDetailResponse) -> [Detail] {
        guard let detail = response.data?.results else { return [Detail]() }
        return detail
    }
}
