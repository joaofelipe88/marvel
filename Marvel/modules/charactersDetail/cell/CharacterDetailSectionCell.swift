//
//  CharacterDetailSectionCell.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 03/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

class CharacterDetailSectionCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var details: [Detail]?
    private let characterDetailCell = "CharacterDetailCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Setup

    private func registerCells() {
        collectionView.register(UINib(nibName: characterDetailCell, bundle: nil), forCellWithReuseIdentifier: characterDetailCell)
    }
    
    func setup(details: [Detail]) {
        registerCells()
        self.details = details
        collectionView.reloadData()
    }

}

// MARK: - CollectionViewDelegate & CollectionViewDataSource Methods

extension CharacterDetailSectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return details?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: characterDetailCell, for: indexPath) as? CharacterDetailCell else {
            return UICollectionViewCell()
        }
        
        if let detail = details?[indexPath.row] {
            cell.setup(detail: detail)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 150, height: 178)
    }
}
