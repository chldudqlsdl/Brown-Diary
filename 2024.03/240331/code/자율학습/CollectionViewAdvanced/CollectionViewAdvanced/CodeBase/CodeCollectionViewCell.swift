//
//  CodeCollectionViewCell.swift
//  CollectionViewAdvanced
//
//  Created by Youngbin Choi on 3/31/24.
//

import UIKit

class CodeCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabel)
        
        imageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(imageView.snp.height).multipliedBy(10 / 14)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
        }
        
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
    }
    
    func configure(title: String) {
        imageView.image = UIImage(named: title)
        titleLabel.text = title
    }
    
}
