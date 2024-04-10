//
//  DetailViewController.swift
//  GhibliMembers+MVVM
//
//  Created by Youngbin Choi on 4/10/24.
//

import UIKit
import Then
import SnapKit

class DetailViewController: UIViewController {
    
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
        $0.setTitle("생성하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.frame.size.height = 40
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
//        $0.addTarget(self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
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
    
    // MVVM
    var viewModel : MemberViewModel
    
    init(viewModel: MemberViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        view.backgroundColor = .systemBackground
        setConstraints()
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
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
    }


}
