//
//  MainTabController.swift
//  TwitterTutorial
//
//  Created by Youngbin Choi on 4/10/24.
//

import UIKit
import Then
import SnapKit

class MainTabController: UITabBarController {
    
    
    // MARK: - Properties
    let actionButton = UIButton(type: .system).then {
        $0.tintColor = .systemBackground
        $0.backgroundColor = .twitterBlue
        $0.setImage(UIImage(named: "new_tweet"), for: .normal)
        $0.layer.cornerRadius = 28
        $0.addTarget(MainTabController.self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
         
        configureViewControllers()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func actionButtonTapped() {
        print(123)
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.height.width.equalTo(56)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(64)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configureViewControllers() {
        
        let feed = FeedController()
        let nav1 = templateNaviagtionController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        let explore = ExploreController()
        let nav2 = templateNaviagtionController(image: UIImage(named: "search_unselected"), rootViewController: explore)
        let notifications = NotificationsController()
        let nav3 = templateNaviagtionController(image: UIImage(named: "like_unselected"), rootViewController: notifications)
        let conversations = ConversationsController()
        let nav4 = templateNaviagtionController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversations)
        
        viewControllers = [nav1, nav2, nav3, nav4]
        
    }
    
    func templateNaviagtionController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        return nav
    }
    
}
