//
//  CharactersRequestSpec.swift
//  MarvelTests
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Quick
import Nimble
import RxSwift

@testable import Marvel

class CharactersRequestSpec: QuickSpec {

    override func spec() {
        
        describe("Testing Character Request") {
            
            it("Testing", closure: {
                
                let disposeBag = DisposeBag()
                
                waitUntil(timeout: 10.0, action: { done in
                    CharactersListDataManager().getCharacters(lastIndex: 0)
                        .subscribe(onNext: { models in
                            expect(models.count).to(equal(20))
                            done()
                        }).disposed(by: disposeBag)
                })
            })
        }
    }
}
