//
//  RegistrationController.swift
//  TwitterTutorial
//
//  Created by Youngbin Choi on 4/11/24.
//

import Foundation
import UIKit
import Then
import SnapKit
import FirebaseAuth
import FirebaseDatabaseInternal
import FirebaseStorage

class RegistrationController: UIViewController{
    
    
    // MARK: - Properties
    private let imagePicker = UIImagePickerController()
    
    private var profileImage : UIImage?
    
    private let plusPhotoButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "plus_photo"), for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
    }
    
    private lazy var emailContainer = Utilities().inputContainerView(with: UIImage(named: "ic_mail_outline_white_2x-1")!, textField: emailTextField)
    
    private lazy var passwordContainer = Utilities().inputContainerView(with: UIImage(named: "ic_lock_outline_white_2x")!, textField: passwordTextField)
    
    private lazy var fullNameContainer = Utilities().inputContainerView(with: UIImage(named: "ic_person_outline_white_2x")!, textField: fullNameTextField)
    
    private lazy var usernameContainer = Utilities().inputContainerView(with: UIImage(named: "ic_person_outline_white_2x")!, textField: usernameTextField)
    
    private let emailTextField = Utilities().textField(withPlaceholder: "Email").then {
        $0.autocapitalizationType = .none
    }
    
    private let passwordTextField = Utilities().textField(withPlaceholder: "Password").then {
        $0.isSecureTextEntry = true
    }
    
    private let fullNameTextField = Utilities().textField(withPlaceholder: "Full Name")
    
    private let usernameTextField = Utilities().textField(withPlaceholder: "Username")
    
    private let signUpButton = UIButton(type: .system).then {
        $0.setTitle("Sign Up", for: .normal)
        $0.setTitleColor(UIColor.twitterBlue, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }

    
    private lazy var stackView = UIStackView().then {
        $0.spacing = 20
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.addArrangedSubview(emailContainer)
        $0.addArrangedSubview(passwordContainer)
        $0.addArrangedSubview(fullNameContainer)
        $0.addArrangedSubview(usernameContainer)
        $0.addArrangedSubview(signUpButton)
    }
    
    private let alreadyHaveAccountButton = Utilities().attributedButton("Already have an account?", " Log in").then {
        $0.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setImagePicker()
    }
    
    
    // MARK: - Selectors
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true)
    }
    
    @objc func handleSignUp() {
        guard let profileImage = profileImage else {
            print("profile image please")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullName = fullNameTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        
        let credentials = AuthCredentials(email: email, password: password, fullName: fullName, username: username, profileImage: profileImage)
        
        AuthService.shared.registerUser(authCredentials: credentials) { error, ref in
            print("Sucessfully updated user information...")
//            self.navigationController?.popViewController(animated: true)
            
            guard let tab = self.view.window?.rootViewController as? MainTabController else { return }
            tab.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.height.equalTo(128)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(plusPhotoButton.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(32)
        }
        signUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func setImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        
        self.profileImage = profileImage
        
        self.plusPhotoButton.then {
            $0.layer.cornerRadius = 64
            $0.layer.masksToBounds = true
            $0.imageView?.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 1
        }
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        picker.dismiss(animated: true)
    }
}

