//
//  ViewController.swift
//  Until0327
//
//  Created by Youngbin Choi on 3/27/24.
//

import UIKit
import Then
import SnapKit

final class FirstViewController: UIViewController {
    
    var password = "0000"
    
    var isLoggedIn = true
    
    private lazy var weatherButton = UIButton(type: .system).then {
        $0.setTitle("날씨 확인하기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(weatherBtnTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        setNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isLoggedIn {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
    }
    
    func makeUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(weatherButton)
        
        weatherButton.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(80)
        }
    }
    
    func setNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
        
        title = "로비"
    }
    
    @objc func weatherBtnTapped() {
        let vc = WeatherViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

