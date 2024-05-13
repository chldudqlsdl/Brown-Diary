//
//  StockRankViewController.swift
//  StockRank
//
//  Created by Youngbin Choi on 10/5/23.
//

import UIKit

class StockRankViewController: UIViewController {
    
    let stockList = StockModel.list

    @IBOutlet weak var collectionView: UICollectionView!
    
    // Data, Presentation, Layout
    // Data - 어떤 데이터? -> stockList
    // Presentation - 셀을 어떻게 표현할거야?
    // Layout - 셀을 어떻게 배치할거야?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension StockRankViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stockList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockRankCollectionViewCell", for: indexPath) as? StockRankCollectionViewCell else {
            return UICollectionViewCell()
        }
        let stock = stockList[indexPath.item]
        cell.configure(stock)
        return cell
    }
}

extension StockRankViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 너비는 컬렉션 뷰랑 같고, 높이는 80정도?
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
}
