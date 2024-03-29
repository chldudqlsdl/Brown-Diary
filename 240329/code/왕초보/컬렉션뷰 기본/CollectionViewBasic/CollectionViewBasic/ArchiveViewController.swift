//
//  ViewController.swift
//  CollectionViewBasic
//
//  Created by Youngbin Choi on 3/29/24.
//

import UIKit

class ArchiveViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
}

extension ArchiveViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Ghibli.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArchiveCollectionViewCell", for: indexPath) as? ArchiveCollectionViewCell else { return UICollectionViewCell()}
        
        cell.configure(title: Ghibli.list[indexPath.row])
        
        return cell
    }
}

extension ArchiveViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interSpacing = 10.0
        let width = (collectionView.bounds.width - interSpacing * 2) / 2
        let height = width * 1.6
        
        return CGSize(width: width, height: height)
    }
    
}



