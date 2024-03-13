//
//  FirstViewController.swift
//  NextVC
//
//  Created by Youngbin Choi on 3/13/24.
//

import UIKit

class FirstViewController: UIViewController {
    
    let mainLabel = UILabel()
    let backButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.setTitle("Back", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    var someString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.text = someString
        mainLabel.font = UIFont.systemFont(ofSize: 22)
        
        view.addSubview(mainLabel)
        view.addSubview(backButton)
        
        view.backgroundColor = .gray
        
        configureUI()

    }
    
    func configureUI() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }


}

