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
        imageView.image = image
        
        view.addSubview(imageView)
        view.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        imageView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(8)
            $0.width.height.equalTo(24)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview()
        }
        return view
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.textColor = .white
        return tf
    }
}
