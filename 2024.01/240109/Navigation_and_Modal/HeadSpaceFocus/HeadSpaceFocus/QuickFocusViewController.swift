//
//  QuickFocusViewController.swift
//  HeadSpaceFocus
//
//  Created by Youngbin Choi on 1/9/24.
//

import UIKit

class QuickFocusViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var breathingList : [QuickFocus] = QuickFocus.breathing
    var walkingList : [QuickFocus] = QuickFocus.walking
    
    enum Section : CaseIterable {
        case breathing
        case walking
        
        var title : String {
            switch self {
            case .breathing: return "Breathing exercises"
            case .walking: return "Mindful Walks"
            }
        }
    }
    
    typealias Item = QuickFocus
    
    var dataSource : UICollectionViewDiffableDataSource<Section, Item>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickFocusCell", for: indexPath) as? QuickFocusCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "QuickFocusHeaderView", for: indexPath) as? QuickFocusHeaderView else {
                return nil
            }
            let allSections = Section.allCases
            let section = allSections[indexPath.section]
            header.configure(section.title)
            return header
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.breathing, .walking])
        snapshot.appendItems(breathingList, toSection: .breathing)
        snapshot.appendItems(walkingList, toSection: .walking)
        dataSource.apply(snapshot)
        self.navigationItem.largeTitleDisplayMode = .never
        
        collectionView.collectionViewLayout = layout()
        
    }
    
    func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20)
        section.interGroupSpacing = 10
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
