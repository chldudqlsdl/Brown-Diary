//
//  MyTableViewCell.swift
//  TableViewCode
//
//  Created by Youngbin Choi on 3/28/24.
//

import UIKit
import Then
import SnapKit

class MyTableViewCell: UITableViewCell {

    let mainImageView = UIImageView().then {
        $0.backgroundColor = .white
    }
    
    let movieNameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.numberOfLines = 0
    }
    
    lazy var stackView = UIStackView().then {
        $0.addArrangedSubview(movieNameLabel)
        $0.addArrangedSubview(descriptionLabel)
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 8
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(mainImageView)
        self.contentView.addSubview(stackView)
        
        setConstraint()
    }
    
    func setConstraint() {
        mainImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(100)
            $0.leading.equalTo(self.contentView).inset(10)
            $0.centerY.equalTo(self.contentView)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing).offset(15)
            $0.top.equalTo(mainImageView.snp.top)
            $0.bottom.equalTo(mainImageView.snp.bottom)
            $0.trailing.equalToSuperview()
        }
        
        movieNameLabel.snp.makeConstraints {
            $0.height.equalTo(22)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


