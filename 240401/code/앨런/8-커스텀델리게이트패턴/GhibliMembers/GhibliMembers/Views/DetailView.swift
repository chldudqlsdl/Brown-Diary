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

    let imageView = UIImageView().then {
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        self.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
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
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}


