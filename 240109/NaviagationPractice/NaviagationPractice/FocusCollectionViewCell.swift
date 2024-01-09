//
//  FocusCollectionViewCell.swift
//  NaviagationPractice
//
//  Created by Youngbin Choi on 1/9/24.
//

import UIKit

class FocusCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var focusTitle: UILabel!
    @IBOutlet weak var focusDescription: UILabel!
    @IBOutlet weak var focusThumbnail: UIImageView!
    
    func configure(_ focus: Focus) {
        focusTitle.text = focus.title
        focusDescription.text = focus.description
        focusThumbnail.image = UIImage(systemName: focus.imageName)
    }
}
