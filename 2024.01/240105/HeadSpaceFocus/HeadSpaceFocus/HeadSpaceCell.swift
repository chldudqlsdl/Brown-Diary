//
//  HeadSpaceCell.swift
//  HeadSpaceFocus
//
//  Created by Youngbin Choi on 1/5/24.
//

import UIKit

class HeadSpaceCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.systemIndigo
        contentView.layer.cornerRadius = 10
    }
    
    func configure(_ focus : Focus) {
        titleLabel.text = focus.title
        descriptionLabel.text = focus.description
        thumbnail.image = UIImage(systemName: focus.imageName)?.withRenderingMode(.alwaysOriginal)
    }
}
