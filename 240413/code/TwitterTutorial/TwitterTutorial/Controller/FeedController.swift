//
//  FeedController.swift
//  TwitterTutorial
//
//  Created by Youngbin Choi on 4/10/24.
//

import UIKit
import Then
import Kingfisher

class FeedController: UIViewController {

    // MARK: - Properties
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    
    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        
    }
    
    func configureLeftBarButton() {
        guard let user = user else { return }
        
        let profileImageView = UIImageView().then {
            $0.backgroundColor = .twitterBlue
            $0.setDimensions(width: 32, height: 32)
            $0.layer.cornerRadius = 16
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFill

            $0.kf.setImage(with: user.profileImageUrl)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}



