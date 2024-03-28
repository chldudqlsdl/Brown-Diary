//
//  DetailView.swift
//  TableViewCode
//
//  Created by Youngbin Choi on 3/28/24.
//

import UIKit
import Then
import SnapKit

final class DetailView: UIView {

    let mainImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    let movieNameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.numberOfLines = 0
    }
    
    lazy var stackView = UIStackView().then {
        $0.addArrangedSubview(mainImageView)
        $0.addArrangedSubview(movieNameLabel)
        $0.addArrangedSubview(descriptionLabel)
        $0.axis = .vertical
        $0.spacing = 15
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stackView)
        setupConstraints()
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
        }
        mainImageView.snp.makeConstraints {
            $0.height.equalTo(240)
        }
        movieNameLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
