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
    
    
    private let characterDetailSectionCell = "CharacterDetailSectionCell"
    private let characterDetailHeader = "CharacterDetailHeader"
    var presenter: CharacterDetailPresenterProtocol?
    var comics: [Detail]?
    var series: [Detail]?
    let headerTitle = ["Comics", "Series"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
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
    
    // MARK: - Setup

    private func registerCells() {
        collectionView.register(UINib(nibName: characterDetailSectionCell, bundle: nil), forCellWithReuseIdentifier: characterDetailSectionCell)
        collectionView.register(UINib(nibName: characterDetailHeader, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: characterDetailHeader)
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
        DispatchQueue.main.async {
            self.comics = comics
            self.collectionView.reloadData()
        }
    }
    
    func showSeries(forDetail series: [Detail]) {
        DispatchQueue.main.async {
            self.series = series
            self.collectionView.reloadData()
        }
    }
}

// MARK: - CollectionViewDelegate & CollectionViewDataSource Methods

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: characterDetailSectionCell, for: indexPath) as? CharacterDetailSectionCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.section == 0 {
            if let comics = comics {
                cell.setup(details: comics)
            }
            return cell
            
        } else {
            if let series = series {
                cell.setup(details: series)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: 178)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: characterDetailHeader, for: indexPath) as? CharacterDetailHeader else {
                return UICollectionReusableView()
            }
            headerView.setupHeader(headerTitle[indexPath.section])
            return headerView
        }
        
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: 50)
    }
}
