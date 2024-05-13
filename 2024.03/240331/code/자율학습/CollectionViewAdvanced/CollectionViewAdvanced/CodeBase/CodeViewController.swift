//
//  CodeViewController.swift
//  CollectionViewAdvanced
//
//  Created by Youngbin Choi on 3/31/24.
//

import UIKit
import Then
import SnapKit

class CodeViewController: UIViewController {
    
    var dataSource : UICollectionViewDiffableDataSource<Section, Movie>!
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CodeCollectionViewCell.self, forCellWithReuseIdentifier: "CodeCollectionViewCell")
        setupUI()
        setDataSource()
        setSnapshot()
        setLayout()
    }
    
    func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CodeCollectionViewCell", for: indexPath) as? CodeCollectionViewCell else { return UICollectionViewCell() }
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
