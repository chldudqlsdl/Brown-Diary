//
//  ViewController.swift
//  EmotionInsideout
//
//  Created by Youngbin Choi on 3/29/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    var originBgColor = "FFFFFF"
    
    var emotionColors = ["F6FDFF", "F9F9E8", "FFF4F3", "F8FCF0", "FDF8FF"]
    
    let myUserDefaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        view.backgroundColor = UIColor(hexCode: myUserDefaults.string(forKey: "bgColor") ?? originBgColor)
    }
    
    @IBAction func emoBtnTapper(_ sender: UIButton) {
        print(sender.tag)
        myUserDefaults.set(emotionColors[sender.tag], forKey: "bgColor")
        view.backgroundColor = UIColor(hexCode: myUserDefaults.string(forKey: "bgColor") ?? originBgColor)
    }
    
    func setupUI() {
        button0.layer.cornerRadius = 50
        button1.layer.cornerRadius = 50
        button2.layer.cornerRadius = 50
        button3.layer.cornerRadius = 50
        button4.layer.cornerRadius = 50
        button0.layer.masksToBounds = true
        button1.layer.masksToBounds = true
        button2.layer.masksToBounds = true
        button3.layer.masksToBounds = true
        button4.layer.masksToBounds = true
    }

}



