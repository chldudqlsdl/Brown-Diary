//
//  LoginViewController.swift
//  Until0327
//
//  Created by Youngbin Choi on 3/27/24.
//

import UIKit
import Then
import SnapKit

final class LoginViewController: UIViewController {
    
    private lazy var passwordView = UIView().then {
        $0.addSubview(passwordTextField)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    private lazy var passwordTextField = UITextField().then {
        $0.textColor = .black
        $0.placeholder = "비밀번호를 입력하세요"
    }
    
    private lazy var passwordButton = UIButton(type: .system).then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        $0.setTitle("입력", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(passwordBtnTapped), for: .touchUpInside)
    }
    
    private lazy var stackView = UIStackView().then {
        $0.addArrangedSubview(passwordView)
        $0.addArrangedSubview(passwordButton)
        $0.axis = .vertical
        $0.spacing = 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        
        passwordTextField.delegate = self
    }
    
    func makeUI() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(300)
            $0.height.equalTo(48 * 2 + 10)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
            
        passwordButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
    }
    
    @objc func passwordBtnTapped() {
        
        if let presentingVC = presentingViewController {
            let tabBarCon = presentingVC as! UITabBarController
            let navCon = tabBarCon.viewControllers?[0] as! UINavigationController
            let firstVC = navCon.viewControllers[0] as! FirstViewController
            if firstVC.password == passwordTextField.text {
                firstVC.isLoggedIn = true
                dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        passwordButton.titleLabel?.textColor = .black
    }
}
