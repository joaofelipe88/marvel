//
//  CharacterDetailEntitySpec.swift
//  MarvelTests
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Quick
import Nimble

@testable import Marvel

class CharacterDetailEntitySpec: QuickSpec {

    override func spec() {
        describe("Character Detail Entity Spec") {
            var model: CharacterItem!
            
            beforeEach {
                let mock = CharacterItem.generateMock()
                model = mock
            }
            
            it("Testing Name", closure: {
                expect(model.name).to(equal("All-New Guardians of the Galaxy (2017)"))
            })
            
            it("Testing Image", closure: {
                expect(model.resourceURI).to(equal("http://gateway.marvel.com/v1/public/series/23058"))
            })
        }
    }
}
