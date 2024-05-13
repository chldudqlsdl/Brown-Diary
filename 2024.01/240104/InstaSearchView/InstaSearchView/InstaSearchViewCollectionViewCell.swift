//
//  InstaSearchViewCollectionViewCell.swift
//  InstaSearchView
//
//  Created by Youngbin Choi on 1/4/24.
//

import UIKit

class InstaSearchViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(_ imageName : String) {
        imageView.image = UIImage(named: imageName)
    }
    
}
