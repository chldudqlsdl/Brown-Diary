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
    
    private let passwordTextField = Utilities().textField(withPlaceholder: "Password").then {
        $0.isSecureTextEntry = true
    }
    
    private let loginButton = UIButton(type: .system).then {
        $0.setTitle("Log in", for: .normal)
        $0.setTitleColor(UIColor.twitterBlue, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }

    
    private lazy var stackView = UIStackView().then {
        $0.spacing = 20
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.addArrangedSubview(emailContainer)
        $0.addArrangedSubview(passwordContainer)
        $0.addArrangedSubview(loginButton)
    }
    
    private let dontHaveAccountButton = Utilities().attributedButton("Don't have an account?", " Sign Up").then {
        $0.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
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
    
    @objc func handleLogin() {
        print("I'm handleLogin")
    }
    
    @objc func handleShowSignUp() {
        let vc = RegistrationController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
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
            $0.leading.trailing.equalToSuperview().inset(32)
        }
        loginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


