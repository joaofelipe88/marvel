//
//  RepositoryManager.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 05/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit
import CoreData
import RxSwift

class FavoriteRepository {

    func insert(character: Character) -> Observable<Bool> {
        let context = getCoreDataContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: context) else {
            return Observable.just(false)
        }
        let favorite = NSManagedObject(entity: entity, insertInto: context)
        favorite.setValue(character.name, forKey: "name")
        favorite.setValue(character.id, forKey: "id")
        favorite.setValue(character.thumbnail?.path, forKey: "path")
        favorite.setValue(character.thumbnail?.imgExtension, forKey: "imgExtension")
        do {
            try context.save()
        } catch {
            return Observable.just(false)
        }
        return Observable.just(true)
    }
    
    func delete(character: Character) -> Observable<Bool> {
        let context = getCoreDataContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for obj in result as! [NSManagedObject] {
                if let identifier = obj.value(forKey: "id") as? Int, identifier == character.id {
                    context.delete(obj)
                }
            }
            try context.save()
        } catch {
            return Observable.just(false)
        }
        return Observable.just(true)
    }
    
    func fetch() -> Observable<[Character]> {
        let context = getCoreDataContext()
        var models = [Character]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                var character = Character()
                if let name = data.value(forKey: "name") as? String {
                    character.name = name
                }
                if let charId = data.value(forKey: "id") as? Int {
                    character.id = charId
                }
                if let path = data.value(forKey: "path") as? String {
                    character.thumbnail?.path = path
                }
                if let imgExtension = data.value(forKey: "imgExtension") as? String {
                    character.thumbnail?.imgExtension = imgExtension
                }
                models.append(character)
            }
        } catch {
            return Observable.error(CustomError(msg: "Failed fetching"))
        }
        
        return Observable.just(models)
    }
    
    func find(character: Character) -> Observable<[Character]> {
        return Observable.create({ (observer) -> Disposable in
            
            let research = self.fetch()
                .subscribe(onNext: { (models) in
                    let filtered = models.filter { $0.id ==  character.id }
                    observer.onNext(filtered)
                    observer.onCompleted()
                }, onError: { _ in
                    if let charName = character.name {
                        observer.onError(CustomError(msg: "Failed finding character \(charName)"))
                    } else {
                        observer.onError(CustomError(msg: "Failed finding character"))
                    }
                })
            
            return Disposables.create {
                research.dispose()
            }
        })
    }
    
    private func getCoreDataContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
