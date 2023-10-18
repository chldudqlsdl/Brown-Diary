//
//  HomeCell.swift
//  InstaSearchView
//
//  Created by Youngbin Choi on 10/19/23.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    
    func configure(_ imageName: String) {
        thumbnailImageView.image = UIImage(named: imageName)
    }
}
