//
//  ApiRequest.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import Foundation
import RxSwift

class ApiRequest<T: Decodable> {
    
    private let errorMessage = "Something went wrong on fetching heroes"
    
    func requestObject(urlString: String) -> Observable<T> {
        var remoteTask: URLSessionTask!
        guard let url = URL(string: urlString)  else {
            return Observable.error(CustomError(msg: self.errorMessage))
        }
        return Observable<T>.create({ observer -> Disposable in
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            remoteTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                guard error == nil else {
                    if let msgError = error?.localizedDescription {
                        observer.onError(CustomError(msg: msgError))
                    } else {
                        observer.onError(CustomError(msg: self.errorMessage))
                    }
                    observer.onCompleted()
                    return
                }
                
                guard let dataReceived = data else {
                    observer.onError(CustomError(msg: self.errorMessage))
                    observer.onCompleted()
                    return
                }
                do {
                    let objectResponse = try JSONDecoder().decode(T.self, from: dataReceived)
                    observer.onNext(objectResponse)
                    observer.onCompleted()
                } catch let error {
                    observer.onError(CustomError(msg: error.localizedDescription))
                    observer.onCompleted()
                }
            }
            
            remoteTask.resume()
            
            return Disposables.create {
                remoteTask.cancel()
            }
        })
    }
    
}
