//
//  ArchiveCollectionViewCell.swift
//  CollectionViewBasic
//
//  Created by Youngbin Choi on 3/29/24.
//

import UIKit

class ArchiveCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    
        
    func configure(title : String) {
        posterImageView.image = UIImage(named: title)
        posterImageView.layer.cornerRadius = 5
        posterImageView.layer.masksToBounds = true
        titleView.text = title
    }
    
}
