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
        
        self.charFavoriteButton.isSelected = !self.charFavoriteButton.isSelected
        //        character.isFavorite()
        //            .observeOn(MainScheduler.instance)
        //            .subscribe(onNext: {[weak self] isFavorite in
        //                guard let self = self else { return }
        //                self.configureFavorite(isFavorite: isFavorite)
        //            }).disposed(by: disposeBag)
    }
}
