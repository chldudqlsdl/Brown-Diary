//
//  SearchCollectionViewCell.swift
//  CollectionViewAdvanced
//
//  Created by Youngbin Choi on 3/31/24.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
    }
    
    func configure(title: String) {
        imageView.image = UIImage(named: title)
        titleLabel.text = title
    }
}
