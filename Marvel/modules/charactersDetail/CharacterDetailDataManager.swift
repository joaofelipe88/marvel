//
//  CharacterDetailDataManager.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 03/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation
import RxSwift

class CharacterDetailDataManager: ApiServices, CharacterDetailRemoteDataManagerInputProtocol {

    var remoteRequestHandler: CharacterDetailRemoteDataManagerOutputProtocol?
    let disposeBag = DisposeBag()
    
    func retrieveCharDetail(forChar char: Character) {
        
        var comicsArray = [Detail]()
        var seriesArray = [Detail]()
        
        if let comics = char.comics?.items {

            for item in comics {
                if let resourceUri = item.resourceURI {
                    getDetail(resourceUri: resourceUri)
                    .subscribe(onNext: { comics in
                        if let comic = comics.first {
                            comicsArray.append(comic)
                        }
                    }, onCompleted: {
                        self.remoteRequestHandler?.onComicsDetailRetrieved(comicsArray)
                    }).disposed(by: disposeBag)
                }
            }
        }

        if let series = char.series?.items {

            for item in series {
                if let resourceUri = item.resourceURI {
                    getDetail(resourceUri: resourceUri)
                    .subscribe(onNext: { series in
                        if let serie = series.first {
                            seriesArray.append(serie)
                        }
                    }, onCompleted: {
                        self.remoteRequestHandler?.onSeriesDetailRetrieved(seriesArray)
                    }).disposed(by: disposeBag)
                }
            }
        }
        
    }
    
    func getDetail(resourceUri: String) -> Observable<[Detail]> {
        
        let urlRequest = "\(resourceUri.replacingOccurrences(of: "http", with: "https"))?\(defaultParams())"
        
        return ApiRequest<CharacterDetailResponse>()
            .requestObject(urlString: "\(urlRequest)")
            .map { CharacterDetailMapper().mapCharacterDetail(response: $0) }
    }
}
