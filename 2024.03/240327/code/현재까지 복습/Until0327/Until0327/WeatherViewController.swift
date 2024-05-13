//
//  WeatherViewController.swift
//  Until0327
//
//  Created by Youngbin Choi on 3/27/24.
//

import UIKit
import Then
import SnapKit

final class WeatherViewController: UIViewController {
    
    private var weatherImageView = UIImageView().then {
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold)
        
        $0.image = UIImage(systemName: "cloud.sun.rain.fill", withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    func makeUI() {
        view.addSubview(weatherImageView)
        view.backgroundColor = .systemGray6
        weatherImageView.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
