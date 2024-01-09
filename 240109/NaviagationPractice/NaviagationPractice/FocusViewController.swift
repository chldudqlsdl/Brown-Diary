//
//  FocusViewController.swift
//  NaviagationPractice
//
//  Created by Youngbin Choi on 1/9/24.
//

import UIKit

class FocusViewController: UIViewController {
    
    let items = Focus.list
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section {
        case main
    }
     typealias Item = Focus
    
    var dataSource : UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FocusCollectionViewCell", for: indexPath) as? FocusCollectionViewCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
    }
    
    func layout() -> UICollectionViewCompositionalLayout {
        
        let section = NSCollectionLayoutSection(group: <#T##NSCollectionLayoutGroup#>)
        let layout = UICollectionViewCompositionalLayout(section: <#T##NSCollectionLayoutSection#>)
        return layout
    }
}
