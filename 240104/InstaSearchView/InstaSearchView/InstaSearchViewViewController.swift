//
//  InstaSearchViewViewController.swift
//  InstaSearchView
//
//  Created by Youngbin Choi on 1/4/24.
//

import UIKit

class InstaSearchViewViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.navigationItem.title = "Search"
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
    }
}

extension InstaSearchViewViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let search = searchController.searchBar.text
        print(search)
    }
    
}

extension InstaSearchViewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstaSearchViewCollectionViewCell", for: indexPath) as? InstaSearchViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        let imageName = "animal\(indexPath.item + 1)"
        cell.configure(imageName)
        return cell
    }
    
}

extension InstaSearchViewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = 1.0
        let width = (collectionView.bounds.width - spacing * 2) / 3
        let height = width
        return CGSize(width: width, height: height)
    }
}
