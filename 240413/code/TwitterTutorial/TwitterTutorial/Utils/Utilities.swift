//
//  Utilities.swift
//  TwitterTutorial
//
//  Created by Youngbin Choi on 4/11/24.
//

import Foundation
import UIKit
import SnapKit

class Utilities {
    
    func inputContainerView(with image: UIImage, textField: UITextField) -> UIView {
        
        let view = UIView()
        let imageView = UIImageView()
        let dividerView = UIView()
        
        imageView.image = image
        dividerView.backgroundColor = .white
        
        view.addSubview(imageView)
        view.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
            $0.width.height.equalTo(24)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview()
        }
        
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(0.75)
        }
        
        return view
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white ])
        
        attributedTitle.append(NSMutableAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white ]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
}


