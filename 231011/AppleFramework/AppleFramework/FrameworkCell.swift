//
//  FrameworkCollectionViewCell.swift
//  AppleFramework
//
//  Created by Youngbin Choi on 10/12/23.
//

import UIKit

class FrameworkCell: UICollectionViewCell {
    @IBOutlet weak var frameworkName: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    func configure(_ appleFramework : AppleFramework ){
        thumbnailImage.image = UIImage(named: appleFramework.imageName)
        frameworkName.text = appleFramework.name
    }
}
