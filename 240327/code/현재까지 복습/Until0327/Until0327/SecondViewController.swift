//
//  SecondViewController.swift
//  Until0327
//
//  Created by Youngbin Choi on 3/27/24.
//

import UIKit
import Then
import SnapKit

final class SecondViewController: UIViewController {
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "훈련일정은 다음과 같습니다"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .black
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    func makeUI() {
        view.addSubview(titleLabel)
        view.backgroundColor = .white
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
