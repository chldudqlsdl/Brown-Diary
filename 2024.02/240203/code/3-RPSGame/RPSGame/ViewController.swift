//
//  ViewController.swift
//  RPSGame
//
//  Created by Allen H on 2021/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var winLose: UILabel!

    @IBOutlet weak var comImage: UIImageView!
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var comChoice: UILabel!
    @IBOutlet weak var myChoice: UILabel!
    
    var myPick : Rps?
    var comPick : Rps?
    var images = [UIImage(named: "rock"), UIImage(named: "paper"), UIImage(named: "scissors")]
    var rpsTexts = ["바위", "보", "가위"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
        
    }
    @IBAction func sButton(_ sender: Any) {
        myPick = .scissors
        comRandom()
    }
    @IBAction func rButton(_ sender: Any) {
        myPick = .rock
        comRandom()
    }
    @IBAction func pButton(_ sender: Any) {
        myPick = .paper
        comRandom()
    }
    @IBAction func resetButton(_ sender: Any) {
        reset()
    }
    @IBAction func selectButton(_ sender: Any) {
        guard let myPick = myPick else {return}
        comImage.image = images[comPick!.rawValue]
        myImage.image = images[myPick.rawValue]
        comChoice.text = rpsTexts[comPick!.rawValue]
        myChoice.text = rpsTexts[myPick.rawValue]
        winLose.text = DidWin()
    }
    
    
    func reset() {
        comImage.image = UIImage(named: "ready")
        myImage.image = UIImage(named: "ready")
        comChoice.text = "준비"
        myChoice.text = "준비"
        winLose.text = "선택하세요"
        myPick =  nil
        comPick = nil
    }
    
    func comRandom() {
        comPick = Rps(rawValue: Int.random(in: 0...2))
    }
    
    func DidWin() -> String {
        if myPick!.rawValue != comPick!.rawValue {
            if myPick!.rawValue == 0 {
                if comPick!.rawValue == 1 {
                    return "졌다"
                } else {
                    return "이겼다"
                }
            } else if myPick!.rawValue == 1 {
                if comPick!.rawValue == 0 {
                    return "이겼다"
                } else {
                    return "졌다"
                }
            } else {
                if comPick!.rawValue == 0 {
                    return "졌다"
                } else {
                    return "이겼다"
                }
            }
        } else {
            return "무승부"
        }
    }
}

