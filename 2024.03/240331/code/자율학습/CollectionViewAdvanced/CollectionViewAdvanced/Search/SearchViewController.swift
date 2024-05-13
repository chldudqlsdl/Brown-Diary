//
//  SearchViewController.swift
//  CollectionViewAdvanced
//
//  Created by Youngbin Choi on 3/31/24.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dataSource : UICollectionViewDiffableDataSource<Section, Movie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setDataSource()
        setSnapshot()
        setLayout()
    }
    
    func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(title: item.title)
            return cell
        })
    }
    
    func setSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Ghibli.main, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    func setLayout() {
        collectionView.collectionViewLayout = layout()
        
        func layout() -> UICollectionViewCompositionalLayout {
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            let section = NSCollectionLayoutSection(group: group)
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        updateSnapshot(with: searchText)
    }
    
    func updateSnapshot(with filter : String?) {
        let filtered = Ghibli.main.filter {$0.title.hasPrefix(filter ?? "")}
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filtered, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}
