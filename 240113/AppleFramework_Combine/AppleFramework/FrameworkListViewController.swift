//
//  FrameworkListViewController.swift
//  AppleFramework
//
//  Created by joonwon lee on 2022/04/24.
//

import UIKit
import Combine

class FrameworkListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = AppleFramework
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
//    let list: [AppleFramework] = AppleFramework.list
    
    // Combine
    var subscriptions = Set<AnyCancellable>()
    let didSelect = PassthroughSubject<AppleFramework, Never>()
    @Published var list: [AppleFramework] = AppleFramework.list

    
    // Data, Presentation, Layout
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // presentation + layout
        configureCollectiveView()
        bind()
        // data
        
        
    }
    private func bind() {
        // input -> item 이 선택되었을 때
        didSelect
            .receive(on: RunLoop.main)
            .sink { [unowned self] framework in
            let sb = UIStoryboard(name: "Detail", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "FrameworkDetailViewController") as! FrameworkDetailViewController
            vc.framework = framework
            
            self.present(vc, animated: true)
        }
            .store(in: &subscriptions)
        // output -> items 가 세팅이 되었을 때(ex - 서버통신)
        $list
            .receive(on: RunLoop.main)
            .sink {[unowned self] list in
            self.applySectionItems()
        }
            .store(in: &subscriptions)
    }
    
    
    private func applySectionItems(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    private func configureCollectiveView(){
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameworkCell", for: indexPath) as? FrameworkCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 10
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalWidth(0.33))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayout, count:   3)
        groupLayout.interItemSpacing = .fixed(spacing)
        
        // Section
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = spacing
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension FrameworkListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let framework = list[indexPath.item]
        print(">>> selected: \(framework.name)")
        didSelect.send(framework)
        
//        let sb = UIStoryboard(name: "Detail", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "FrameworkDetailViewController") as! FrameworkDetailViewController
//        vc.framework = framework
//        
//        present(vc, animated: true)
    }
}
