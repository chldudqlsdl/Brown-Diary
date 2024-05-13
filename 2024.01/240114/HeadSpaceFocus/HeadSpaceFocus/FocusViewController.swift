//
//  FocusViewController.swift
//  HeadSpaceFocus
//
//  Created by Youngbin Choi on 1/14/24.
//

import UIKit

class FocusViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var recommendationBtn: UIButton!
    
    var curated : Bool = false
    var items = Focus.list
    
    enum Section {
        case main
    }
    typealias Item = Focus
    
    var dataSource : UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendationBtn.layer.cornerRadius = 10
        
        //Presentation
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FocusCell", for: indexPath) as? FocusCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        //data
        dataUpdate()
        
        //layout
        collectionView.collectionViewLayout = layout()
        
        //delegate
        collectionView.delegate = self
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    @IBAction func recommendationTapped(_ sender: Any) {
        curated.toggle()
        items = curated ? Focus.recommendations : Focus.list
        dataUpdate()
        
    }
    
    private func dataUpdate() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    private func btnTitleUpdate() {
        let btnTitle = curated ? "See All" : "See Recommendation"
        recommendationBtn.setTitle(btnTitle, for: .normal)
    }
}

extension FocusViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        
        let storyboard = UIStoryboard(name: "QuickFocus", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuickFocusViewController")
        vc.title = item.title
        navigationController?.pushViewController(vc, animated: true)
    }
}
