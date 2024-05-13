//
//  ViewController.swift
//  CollectionViewAdvanced
//
//  Created by Youngbin Choi on 3/30/24.
//

import UIKit

class Case1ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource : UICollectionViewDiffableDataSource<Section, Movie>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDataSource()
        setHeader()
        applySnapshot()
        setLayout()
    }
    
    func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Case1CollectionViewCell", for: indexPath) as? Case1CollectionViewCell else { return UICollectionViewCell()}
            cell.configure(title: item.title)
            return cell
        })
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main, .sub])
        snapshot.appendItems(Ghibli.main, toSection: .main)
        snapshot.appendItems(Ghibli.sub, toSection: .sub)
        dataSource?.apply(snapshot)
    }
    
    func setLayout() {
        collectionView.collectionViewLayout = layout()
        
        
        func layout() -> UICollectionViewCompositionalLayout {
            
            let layout2 = UICollectionViewCompositionalLayout { sectionInt, environment in
                let sectionColumns = Section(rawValue: sectionInt)?.sectionColumn
                let groupHeight = Section(rawValue: sectionInt)?.groupHeight
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(groupHeight!))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: sectionColumns!)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.08))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                return section
            }
            
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.35))
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
//            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .continuous
//            
//            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.08))
//            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//            section.boundarySupplementaryItems = [header]
//            
//            let layout = UICollectionViewCompositionalLayout(section: section)
            
            return layout2
        }
    }
    
    func setHeader() {
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Case1CollectionReusableView", for: indexPath) as? Case1CollectionReusableView else { return nil }
            header.headerLabel.text = Section.allCases[indexPath.section].sectionName
            return header
        }
    }
}
