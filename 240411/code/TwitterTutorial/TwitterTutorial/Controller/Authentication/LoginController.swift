//
//  LoginController.swift
//  TwitterTutorial
//
//  Created by Youngbin Choi on 4/11/24.
//

import Foundation
import UIKit
import Then
import SnapKit

class LoginController: UIViewController {
    
    
    // MARK: - Properties
    private let logoImageView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "TwitterLogo")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    private lazy var emailContainer = Utilities().inputContainerView(with: UIImage(named: "ic_mail_outline_white_2x-1")!, textField: emailTextField)
    
    private lazy var passwordContainer = Utilities().inputContainerView(with: UIImage(named: "ic_lock_outline_white_2x")!, textField: passwordTextField)
    
    private let emailTextField = Utilities().textField(withPlaceholder: "Email")
    
    private let passwordTextField = Utilities().textField(withPlaceholder: "Password")

    
    private lazy var stackView = UIStackView().then {
        $0.spacing = 8
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.addArrangedSubview(emailContainer)
        $0.addArrangedSubview(passwordContainer)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.height.equalTo(150)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
}


