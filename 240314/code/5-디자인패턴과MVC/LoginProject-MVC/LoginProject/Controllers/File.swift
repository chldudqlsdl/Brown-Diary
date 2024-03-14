//
//  File.swift
//  LoginProject
//
//  Created by Youngbin Choi on 3/14/24.
//

import Foundation
import UIKit
 
class ViewControllers: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = CustomView()
    }
}
        
class CustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
