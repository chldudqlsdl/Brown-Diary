//
//  QuickFocusCell.swift
//  HeadSpaceFocus
//
//  Created by Youngbin Choi on 1/9/24.
//

import UIKit

class QuickFocusCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var quickFocusTitle: UILabel!
    @IBOutlet weak var quickFocusDescription: UILabel!
    
    func configure(_ quickFocus: QuickFocus){
        thumbnail.image = UIImage(named: quickFocus.imageName)
        quickFocusTitle.text = quickFocus.title
        quickFocusDescription.text = quickFocus.description
    }
}
