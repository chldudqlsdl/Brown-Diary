//
//  FeedController.swift
//  TwitterTutorial
//
//  Created by Youngbin Choi on 4/10/24.
//

import UIKit

class FeedController: UIViewController {

    // MARK: - Properties
    
    
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
    
    
}

