//
//  DetailView.swift
//  GhibliMembers
//
//  Created by Youngbin Choi on 4/1/24.
//

import UIKit
import Then
import SnapKit

class DetailView: UIView {
    
    var member : Member? {
        didSet {
            guard let member = member else {
                saveButton.setTitle("추가하기", for: .normal)
                idTextField.text = "\(Member.memberNumbers)"
                return
            }
            imageView.image = member.image
            idTextField.text = String(member.memberId)
            nameTextField.text = member.name
            ageTextField.text = member.age != nil ? "\(member.age!)" : ""
        }
    }

    var imageView = UIImageView().then {
        $0.backgroundColor = .lightGray
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 75
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var imageContainView = UIView().then {
        $0.addSubview(imageView)
    }
    
    let idLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.text = "회원번호"
    }
    
    let idTextField = UITextField().then {
        $0.frame.size.height = 22
        $0.textColor = .label
        $0.borderStyle = .roundedRect
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.clearsOnBeginEditing = false
    }
    
    lazy var idStackView = UIStackView().then {
        $0.addArrangedSubview(idLabel)
        $0.addArrangedSubview(idTextField)
        $0.spacing = 5
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    let nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.text = "이      름"
    }
    
    let nameTextField = UITextField().then {
        $0.frame.size.height = 22
        $0.textColor = .label
        $0.borderStyle = .roundedRect
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.clearsOnBeginEditing = false
    }
    
    lazy var nameStackView = UIStackView().then {
        $0.addArrangedSubview(nameLabel)
        $0.addArrangedSubview(nameTextField)
        $0.spacing = 5
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    let ageLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.text = "나      이"
    }
    
    let ageTextField = UITextField().then {
        $0.frame.size.height = 22
        $0.textColor = .label
        $0.borderStyle = .roundedRect
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.clearsOnBeginEditing = false
    }
    
    lazy var ageStackView = UIStackView().then {
        $0.addArrangedSubview(ageLabel)
        $0.addArrangedSubview(ageTextField)
        $0.spacing = 5
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    let saveButton = UIButton(type: .custom).then {
        $0.backgroundColor = .systemBlue
        $0.setTitle("변경하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.frame.size.height = 40
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    lazy var stackView = UIStackView().then {
        $0.addArrangedSubview(imageContainView)
        $0.addArrangedSubview(idStackView)
        $0.addArrangedSubview(nameStackView)
        $0.addArrangedSubview(ageStackView)
        $0.addArrangedSubview(saveButton)
        $0.spacing = 10
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    let labelWidth : CGFloat = 70
    var topConstraint : Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        self.addSubview(stackView)
        setConstraints()
        idTextField.delegate = self
        setupNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setConstraints() {
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(150)
            $0.width.equalTo(150)
            $0.centerX.centerY.equalToSuperview()
        }
        imageContainView.snp.makeConstraints {
            $0.height.equalTo(180)
        }
        idLabel.snp.makeConstraints {
            $0.width.equalTo(labelWidth)
        }
        nameLabel.snp.makeConstraints {
            $0.width.equalTo(labelWidth)
        }
        ageLabel.snp.makeConstraints {
            $0.width.equalTo(labelWidth)
        }
        stackView.snp.makeConstraints {
            topConstraint = $0.top.equalTo(self.safeAreaLayoutGuide).inset(10).constraint
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    
    // MARK: - 노티피케이션 세팅
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveUpAction), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveDownAction), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - 스택뷰 올렸다 내렸다 함수
    
    @objc func moveUpAction() {
        topConstraint?.update(inset: -20)
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func moveDownAction() {
        topConstraint?.update(inset: 10)
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - 소멸될 때 옵저버 제거해주기
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}


// MARK: - 텍스트필드 델리게이트
extension DetailView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == idTextField {
            return false
        }
        return true
    }
}


