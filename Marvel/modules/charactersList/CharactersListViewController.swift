//
//  CharactersListViewController.swift
//  Marvel
//
//  Created by João Felipe Carvalho on 01/03/20.
//  Copyright © 2020 João Felipe Carvalho. All rights reserved.
//

import UIKit

class CharactersListViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let refreshControl = UIRefreshControl()
    
    private let characterCell = "CharactersListCell"
    private var charactersArray = [Character]()
    
    var presenter: CharactersListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        self.presenter.fetchCharacters(pullRefresh: false)
    }
    
    // MARK: - Setup

    private func registerCells() {
        collectionView.register(UINib(nibName: characterCell, bundle: nil), forCellWithReuseIdentifier: characterCell)
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
    }
    
    // MARK: - RefreshAction
    
    @objc private func refreshWeatherData(_ sender: Any) {
        self.presenter.fetchCharacters(pullRefresh: true)
    }
}

// MARK: - CharactersListViewControllerProtocol

extension CharactersListViewController: CharactersListViewControllerProtocol {
    
    func showError(with message: String) {
        showErrorAlert(message)
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func loadCharacters(_ chars: [Character]) {
        self.charactersArray = chars.sorted { $0.name!.lowercased() < $1.name!.lowercased() }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - CollectionViewDelegate & CollectionViewDataSource Methods

extension CharactersListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: characterCell, for: indexPath) as? CharactersListCell else {
            return UICollectionViewCell()
        }
        
        let character =  charactersArray[indexPath.row]
        cell.setup(character: character)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var width = UIScreen.main.bounds.width
        width = (width - 8 * 4) / 2
        return CGSize(width: width, height: width + 50)
    }
}
