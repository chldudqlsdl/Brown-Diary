//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    // SearchBar
    // bind() -> Input, Output
    // UIUpdate
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Combine
    var subscriptions = Set<AnyCancellable>()
    
    let viewModel = SearchViewModel()
    let detailViewModel = DetailViewModel()
    
    enum Section {
        case main
    }
    typealias Item = SearchResult
    
    var dataSource : UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedSearchController()
        configureCollectionView()
        bind()
        collectionView.delegate = self
    }
    
    func embedSearchController() {
        
        navigationItem.title = "Search"
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Your ID"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
    }
    
    func bind() {
        viewModel.users
            .receive(on: RunLoop.main)
            .sink { [unowned self] result in
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])
                snapshot.appendItems(result, toSection: .main)
                self.dataSource.apply(snapshot)
            }
            .store(in: &subscriptions)
    }
    
    func configureCollectionView() {
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else {
                return nil
            }
            cell.user.text = item.login
            return cell
        })
        
        collectionView.collectionViewLayout = layout()
    }
    
    func layout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension SearchViewController : UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let keyword = searchBar.text else { return }
        viewModel.search(keyword)
        
    }
}

extension SearchViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let user = viewModel.users.value[indexPath.item]
        
        print(user)
        
        
        let storyBoard = UIStoryboard(name: "Detail", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "SearchDetailController") as? SearchDetailController else { return }
        
        vc.detailViewModel = detailViewModel
        present(vc, animated: true)
        
        detailViewModel.user.send(user)
    }
}
