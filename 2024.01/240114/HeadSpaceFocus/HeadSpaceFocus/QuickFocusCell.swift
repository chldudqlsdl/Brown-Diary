//
//  QuickFocusCell.swift
//  HeadSpaceFocus
//
//  Created by Youngbin Choi on 1/14/24.
//

import UIKit

class QuickFocusCell: UICollectionViewCell {
    
    @IBOutlet weak var quickFocusImage: UIImageView!
    @IBOutlet weak var quickFocusTitle: UILabel!
    @IBOutlet weak var quickFocusDescription: UILabel!
    
    func configure(_ item : QuickFocus) {
        quickFocusTitle.text = item.title
        quickFocusDescription.text = item.description
        quickFocusImage.image = UIImage(named: item.imageName)
    }
}
