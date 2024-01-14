//
//  FocusCell.swift
//  HeadSpaceFocus
//
//  Created by Youngbin Choi on 1/14/24.
//

import UIKit

class FocusCell: UICollectionViewCell {
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        contentView.backgroundColor = UIColor.systemIndigo
        contentView.layer.cornerRadius = 10
    }
    
    func configure(_ item : Focus){
        cellTitle.text = item.title
        cellDescription.text = item.description
        cellImage.image = UIImage(systemName: item.imageName)?.withRenderingMode(.alwaysOriginal)
    }
}
