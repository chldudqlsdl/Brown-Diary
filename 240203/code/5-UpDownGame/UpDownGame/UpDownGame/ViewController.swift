//
//  ViewController.swift
//  UpDownGame
//
//  Created by Youngbin Choi on 2/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bingoLabel: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    
    var answer : Int?
    var myChoice : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        answer = Int.random(in: 1...10)
        
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        let myPick = sender.currentTitle!
        myLabel.text = myPick
        if let myPick = Int(myPick) {
           myChoice = myPick
        }
    }
    
    @IBAction func selectPressed(_ sender: Any) {
        
        guard let myChoice = myChoice else { return }
        
        if answer! < myChoice {
            bingoLabel.text = "Down"
        } else if answer! > myChoice {
            bingoLabel.text = "Up"
        } else {
            bingoLabel.text = "Bingo😆"
        }
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        bingoLabel.text = "선택하세요"
        myLabel.text = ""
        answer = Int.random(in: 1...10)
        myChoice = nil
    }
    
}

