//
//  CharactersFavoriteViewController.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 05/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

class CharactersFavoriteViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var favoriteErrorView: UIView!
    @IBOutlet weak var favoriteErrorLabel: UILabel!
    
    private let characterCell = "CharactersListCell"
    var presenter: CharactersFavoritePresenterProtocol!
    private var charactersArray = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.fetchCharacters()
    }
    
    // MARK: - Setup

    private func registerCells() {
        collectionView.register(UINib(nibName: characterCell, bundle: nil), forCellWithReuseIdentifier: characterCell)
    }
    
    // MARK: - RefreshAction

    @IBAction func refreshTryAgain(_ sender: Any) {
        presenter.fetchCharacters()
    }
}

// MARK: - CharactersListViewControllerProtocol

extension CharactersFavoriteViewController: CharactersFavoriteViewProtocol {
    
    func showError(with message: String) {
        DispatchQueue.main.async {
            self.favoriteErrorLabel.text = message
            self.favoriteErrorView.isHidden = false
            self.showErrorAlert(message)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.favoriteErrorView.isHidden = true
            self.favoriteErrorLabel.text = "There's no Favorite Heroes"
        }
    }
    
    func emptyView() {
        DispatchQueue.main.async {
            self.favoriteErrorView.isHidden = false
        }
    }
    
    func showCharacters(_ chars: [Character]) {
        DispatchQueue.main.async {
            self.charactersArray = chars.sorted { $0.name!.lowercased() < $1.name!.lowercased() }
            self.collectionView.reloadData()
        }
    }
}

// MARK: - CollectionViewDelegate & CollectionViewDataSource Methods

extension CharactersFavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: characterCell, for: indexPath) as? CharactersListCell else {
            return UICollectionViewCell()
        }
        
        let character = charactersArray[indexPath.row]
        cell.setup(character: character)
        cell.hiddenFavoriteButton()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var width = UIScreen.main.bounds.width
        width = (width - 8 * 4) / 2
        return CGSize(width: width, height: width + 50)
    }
}
