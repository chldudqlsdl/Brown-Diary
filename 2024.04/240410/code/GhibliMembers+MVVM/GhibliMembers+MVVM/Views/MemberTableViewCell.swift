//
//  MemberTableViewCell.swift
//  GhibliMembers+MVVM
//
//  Created by Youngbin Choi on 4/10/24.
//

import UIKit
import Then

class MemberTableViewCell: UITableViewCell {
    
    // MARK: - 뷰 모델
    var viewModel : MemberViewModel! {
        didSet {
            configureUI()
        }
    }
    
    // MARK: - UI 구현
    
    var mainImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    var nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    var ageLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 5
        $0.addArrangedSubview(nameLabel)
        $0.addArrangedSubview(ageLabel)
    }
    
    // MARK: - 생성자
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 세팅
    func setupUI() {
        self.addSubview(mainImageView)
        self.addSubview(stackView)
    }
    
    // MARK: - 오토레이아웃 설정
    func setConstraints() {
        mainImageView.snp.makeConstraints {
            $0.height.width.equalTo(50)
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(mainImageView.snp.top)
            $0.bottom.equalTo(mainImageView.snp.bottom)
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
                
    }
    
    // MARK: - 레이아웃 세팅
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImageView.layer.cornerRadius = self.mainImageView.frame.width / 2
        mainImageView.clipsToBounds = true
    }
    
    // MARK: - 뷰모델로 데이터 세팅
    func configureUI() {
        mainImageView.image = viewModel.memberImage
        nameLabel.text = viewModel.memberName
        ageLabel.text = viewModel.memberAge
    }
}
