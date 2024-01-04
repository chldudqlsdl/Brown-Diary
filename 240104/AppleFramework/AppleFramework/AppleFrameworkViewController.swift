//
//  AppleFrameworkViewController.swift
//  AppleFramework
//
//  Created by Youngbin Choi on 1/4/24.
//

import UIKit

class AppleFrameworkViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    let frameworkDataList : [AppleFramework] = AppleFramework.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self

    }
}

extension AppleFrameworkViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frameworkDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppleFrameworkCollectionViewCell", for: indexPath) as? AppleFrameworkCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let frameworkData = frameworkDataList[indexPath.item]
        cell.configure(frameworkData)
        
        return cell
    }
}

extension AppleFrameworkViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing = 10.0
        let width = collectionView.bounds.width / 3 - spacing
        let height = width * 1.5
        
        return CGSize(width: width, height: height)
    }
}
