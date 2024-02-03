//
//  ViewController.swift
//  DiceGame
//
//  Created by Allen H on 2021/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...6 {
            images.append(UIImage(named: "black\(i)")!)
        }
        randomDice()
        
    }
    @IBAction func buttonPressed(_ sender: Any) {
        randomDice()
    }
    func randomDice() {
//        leftImage.image = images[Int.random(in: 0...5)]
        leftImage.image = images.randomElement()
        rightImage.image = images[Int.random(in: 0...5)]
    }
}

