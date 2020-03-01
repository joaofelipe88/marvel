//
//  CharacterEntitySpec.swift
//  MarvelTests
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Quick
import Nimble

@testable import Marvel

class CharacterEntitySpec: QuickSpec {

    override func spec() {
        describe("Character Entity Spec") {
            var model: Character!
            
            beforeEach {
                var mock = Character.generateMock()
                mock.thumbnail = CharacterThumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/a/f0/5202887448860", imgExtension: "jpg")
                model = mock
            }
            
            it("Testing Character ID", closure: {
                expect(model.characterId).to(equal(1))
            })
            
            it("Testing Name", closure: {
                expect(model.name).to(equal("Adam Warlock"))
            })
            
            it("Testing Image", closure: {
                expect(model.thumbnail?.path).to(equal("http://i.annihil.us/u/prod/marvel/i/mg/a/f0/5202887448860"))
                expect(model.thumbnail?.imgExtension).to(equal("jpg"))
            expect(model.profileImageUrl?.absoluteString).to(equal("http://i.annihil.us/u/prod/marvel/i/mg/a/f0/5202887448860/portrait_xlarge.jpg"))
            })
        }
    }
}

