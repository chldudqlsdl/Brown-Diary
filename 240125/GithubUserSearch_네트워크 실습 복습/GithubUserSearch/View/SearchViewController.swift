//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    // SearchController
    // bind() Output(), Inout()
    // UI
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedSearchControl()
    }
    
    func embedSearchControl() {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "Search by Github ID"
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
    }
}

extension SearchViewController : UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let keyword = searchBar.text , !keyword.isEmpty else { return }
        
        viewModel.Search(keyword)
        
    }
}
