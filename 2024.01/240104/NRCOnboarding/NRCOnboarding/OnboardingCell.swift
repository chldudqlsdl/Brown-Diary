//
//  OnboardingCell.swift
//  NRCOnboarding
//
//  Created by Youngbin Choi on 1/4/24.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(_ message: OnboardingMessage ) {
        imageView.image = UIImage(named: message.imageName)
        title.text = message.title
        descriptionLabel.text = message.description
    }
    
}
