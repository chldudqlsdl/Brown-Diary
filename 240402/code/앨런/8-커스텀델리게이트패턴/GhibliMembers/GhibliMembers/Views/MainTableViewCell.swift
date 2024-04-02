//
//  MainTableViewCell.swift
//  GhibliMembers
//
//  Created by Youngbin Choi on 4/1/24.
//

import UIKit
import Then
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    var member : Member? {
        didSet {
            if let member = member {
                mainImageView.image = member.image
                nameLabel.text = member.name
                ageLabel.text = member.age != nil ? "\(member.age!)세" : ""
            }
        }
    }
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(mainImageView)
        self.addSubview(stackView)
    }
    
//    override func updateConstraints() {
//        super.updateConstraints()
//        setConstraints()
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImageView.layer.cornerRadius = mainImageView.frame.width / 2
        mainImageView.layer.masksToBounds = true
    }
    
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
    
}





