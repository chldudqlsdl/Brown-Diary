//
//  ViewController.swift
//  NewJourney
//
//  Created by Youngbin Choi on 3/10/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    weak var timer : Timer?
    
    var seconds : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    func configureUI() {
        mainLabel.text = "초를 선택하세요"
        
        slider.setValue(0.5, animated: true)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        
        // 슬라이더의 밸류값을 가지고, 메인레이블의 텍스트 세팅
        seconds = Int(sender.value * 60)
        mainLabel.text = "\(seconds)"
        
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        
        // 초기화 세팅
        mainLabel.text = "초를 선택하세요"
        slider.value = 0.5
        seconds = 0
        timer = nil
        
        // 슬라이더 가운데 설정
        slider.setValue(0.5, animated: true)
        
    }
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        // 1초마다 슬라이더가 한 칸씩 내려가기
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
            
            if seconds > 0 {
                seconds -= 1
                
                mainLabel.text = "\(seconds)"
                slider.value = Float(seconds) / Float(60)
                
            } else {
                seconds = 0
                mainLabel.text = "초를 선택하세요"
                
                AudioServicesPlayAlertSound(SystemSoundID(1000))
                
                timer?.invalidate()
            }
        }
        
    }
    
}

