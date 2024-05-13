//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Allen H on 2021/05/15.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    // 해당 앱 화면에 진입했을때 가장 먼저 자동으로 실행되는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //view.backgroundColor = UIColor.yellow
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        mainLabel.text = "안녕하세요"
        
    }
    
}

