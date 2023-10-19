//
//  OnboardingCell.swift
//  NRCOnboarding
//
//  Created by Youngbin Choi on 10/19/23.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    @IBOutlet weak var onboardingImageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(_ message: OnboardingMessage) {
        onboardingImageVIew.image = UIImage(named: message.imageName)
        titleLabel.text = message.title
        descriptionLabel.text = message.description
    }
}
