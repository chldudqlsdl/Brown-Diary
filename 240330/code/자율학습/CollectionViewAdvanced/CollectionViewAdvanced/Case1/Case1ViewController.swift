//
//  ViewController.swift
//  CollectionViewAdvanced
//
//  Created by Youngbin Choi on 3/30/24.
//

import UIKit

class Case1ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section {
        case main
        
        var sectionName : String {
            switch self {
            case .main: return "박스오피스 순위"
            }
        }
    }
    
    var dataSource : UICollectionViewDiffableDataSource<Section, String>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataSource()
        applySnapshot()
        setLayout()
    }
    
    func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Case1CollectionViewCell", for: indexPath) as? Case1CollectionViewCell else { return nil}
            cell.configure(title: item)
            return cell
        })
    }
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Ghibli.list, toSection: .main)
        dataSource?.apply(snapshot)
    }
    func setLayout() {
        collectionView.collectionViewLayout = layout()
        
        func layout() -> UICollectionViewCompositionalLayout {
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.35))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        }
    }
    
    func setHeader() {
        dataSource?.supplementaryViewProvider = {(collectionView, )
            
        }
    }
}




