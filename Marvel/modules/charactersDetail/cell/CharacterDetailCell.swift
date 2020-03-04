//
//  CharacterDetailCell.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 03/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

class CharacterDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Setup
        
        func setup(detail: Detail) {
            
            detailImageView.backgroundColor = .clear
            
            if let title = detail.title, !title.isEmpty {
                detailLabel.text = title
            } else {
                detailLabel.text = "No found"
            }
            
            if let url = getURLImage(detail) {
                detailImageView.kf.indicatorType = .activity
                detailImageView.kf.setImage(with: url)
            } else {
                detailImageView.backgroundColor = .darkGray
            }
        }
        
        func getURLImage(_ detail: Detail) -> URL? {
            
            if let image = detail.thumbnail?.path?.replacingOccurrences(of: "http", with: "https"),
                let imgExtension = detail.thumbnail?.imgExtension,
                let url = URL(string: "\(image)/standard_large.\(imgExtension)") {
                return url
            }
            
            return nil
        }
}
