//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 02/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet weak var charDescriptionLabel: UILabel!
    
    
    private let characterDetailCell = "CharactersDetailCell"
    var presenter: CharacterDetailPresenterProtocol?
    var comics: [Detail]?
    var series: [Detail]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func getURLImage(_ character: Character) -> URL? {
        if let image = character.thumbnail?.path?.replacingOccurrences(of: "http", with: "https"),
            let imgExtension = character.thumbnail?.imgExtension,
            let url = URL(string: "\(image)/standard_fantastic.\(imgExtension)") {
            return url
        }
        
        return nil
    }

}

extension CharacterDetailViewController: CharacterDetailViewProtocol {
    
    func showCharacter(forChar char: Character) {
        
        DispatchQueue.main.async {
            
            if let description = char.description, !description.isEmpty {
                self.charDescriptionLabel.text = description
            } else {
                self.charDescriptionLabel.text = "There's no description for this hero"
            }
            
            if let url = self.getURLImage(char) {
                self.charImageView.kf.indicatorType = .activity
                self.charImageView.kf.setImage(with: url)
            } else {
                self.charImageView.backgroundColor = .darkGray
            }
        }
    }
    
    func showComics(forDetail comics: [Detail]) {
        self.comics = comics
    }
    
    func showSeries(forDetail series: [Detail]) {
        self.series = series
    }
}

// MARK: - CollectionViewDelegate & CollectionViewDataSource Methods

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (section == 0 ? self.comics?.count : self.series?.count) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: characterDetailCell, for: indexPath) as? CharacterDetailCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.section == 0 {
            return cell
            
        } else {
            return cell
        }
    }
    
}
