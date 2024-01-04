//
//  AppleFrameworkCollectionViewCell.swift
//  AppleFramework
//
//  Created by Youngbin Choi on 1/4/24.
//

import UIKit

class AppleFrameworkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frameworkImage: UIImageView!
    @IBOutlet weak var frameworkName: UILabel!
    
    func configure(_ framework : AppleFramework) {
        frameworkImage.image = UIImage(named: framework.imageName)
        frameworkName.text = framework.name
    }
}
