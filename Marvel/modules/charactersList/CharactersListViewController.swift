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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var charactersErrorView: UIView!
    @IBOutlet weak var characterErrorLabel: UILabel!
    
    
    private let refreshControl = UIRefreshControl()
    
    private let characterCell = "CharactersListCell"
    private var charactersArray = [Character]()
    private var lastIndex: Int = 0
    
    var presenter: CharactersListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        self.presenter.fetchCharacters(pullRefresh: false, lastIndex: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.collectionView.reloadData()
    }
    
    // MARK: - Setup

    private func registerCells() {
        collectionView.register(UINib(nibName: characterCell, bundle: nil), forCellWithReuseIdentifier: characterCell)
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    // MARK: - RefreshAction
    
    @objc private func refreshData(_ sender: Any) {
        self.lastIndex = 0
        self.presenter.fetchCharacters(pullRefresh: true, lastIndex: self.lastIndex)
    }
    
    @IBAction func refreshTryAgain(_ sender: Any) {
        
        self.lastIndex = 0
        
        if let string = self.searchBar.text, !string.isEmpty {
            self.presenter.searchCharList(textName: string)
        } else {
            self.presenter.fetchCharacters(pullRefresh: false, lastIndex: 0)
        }
    }
    
}

// MARK: - CharactersListViewControllerProtocol

extension CharactersListViewController: CharactersListViewControllerProtocol {
    
    func showError(with message: String) {
        DispatchQueue.main.async {
            self.characterErrorLabel.text = message
            self.charactersErrorView.isHidden = false
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
            self.refreshControl.endRefreshing()
            self.activityIndicator.stopAnimating()
            self.charactersErrorView.isHidden = true
            self.characterErrorLabel.text = "There's no Heroes"
        }
    }
    
    func emptyView() {
        DispatchQueue.main.async {
            self.charactersErrorView.isHidden = false
        }
    }
    
    func loadCharacters(_ chars: [Character]) {
        
        if self.lastIndex > 0 {
            
            for item in chars {
                self.charactersArray.append(item)
            }
            self.charactersArray = self.charactersArray.sorted { $0.name!.lowercased() < $1.name!.lowercased() }
            
        } else {
            
            self.charactersArray = chars.sorted { $0.name!.lowercased() < $1.name!.lowercased() }
        }
        
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
        
        let character = charactersArray[indexPath.row]
        cell.setup(character: character)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var width = UIScreen.main.bounds.width
        width = (width - 8 * 4) / 2
        return CGSize(width: width, height: width + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let searchText = self.searchBar.text, searchText.isEmpty, indexPath.row == charactersArray.count - 1 {
            self.lastIndex = charactersArray.count
            self.presenter.fetchCharacters(pullRefresh: false, lastIndex: self.lastIndex)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showCharacterDetail(forChar: self.charactersArray[indexPath.row])
    }
}

// MARK: - UISearchBarDelegate Methods

extension CharactersListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let string = searchBar.text, !string.isEmpty {
            self.lastIndex = 0
            self.presenter.searchCharList(textName: string)
        } else {
            self.presenter.fetchCharacters(pullRefresh: false, lastIndex: 0)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}
