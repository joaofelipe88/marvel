//
//  CharactersListCell.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class CharactersListCell: UICollectionViewCell {
    
    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet weak var charNameLabel: UILabel!
    @IBOutlet weak var charFavoriteButton: UIButton!
    
    private var character: Character!
    private var repository: FavoriteRepository!
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Setup
    
    func setup(character: Character) {
        charImageView.backgroundColor = .clear
        self.character = character
        charNameLabel.text = character.name
        
        if let url = getURLImage(character) {
            charImageView.kf.indicatorType = .activity
            charImageView.kf.setImage(with: url)
        } else {
            charImageView.backgroundColor = .darkGray
        }
        
        repository = FavoriteRepository()
        isFavorite()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {[weak self] isFavorite in
            guard let self = self else { return }
            self.charFavoriteButton.isSelected = isFavorite
        }).disposed(by: disposeBag)
        
    }
    
    func hiddenFavoriteButton() {
        self.charFavoriteButton.isHidden = true
    }
    
    func getURLImage(_ character: Character) -> URL? {
        
        if let image = character.thumbnail?.path?.replacingOccurrences(of: "http", with: "https"),
            let imgExtension = character.thumbnail?.imgExtension,
            let url = URL(string: "\(image)/portrait_xlarge.\(imgExtension)") {
            return url
        }
        
        return nil
    }
    
    // MARK: - Favorite Action
    
    @IBAction func favoriteAction(_ sender: Any) {
        
        if self.charFavoriteButton.isSelected {
            unFavorite()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] _ in
                guard let self = self else { return }
                self.charFavoriteButton.isSelected = !self.charFavoriteButton.isSelected
            }).disposed(by: disposeBag)
        } else {
            favorite()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] _ in
                guard let self = self else { return }
                self.charFavoriteButton.isSelected = !self.charFavoriteButton.isSelected
            }).disposed(by: disposeBag)
        }
    }
    
    func isFavorite() -> Observable<Bool> {
        return repository.find(character: self.character)
                    .map { !$0.isEmpty }
    }
    
    func favorite() -> Observable<Bool> {
         return repository.insert(character: self.character)
    }
    
    func unFavorite() -> Observable<Bool> {
        return repository.delete(character: self.character)
    }
}
