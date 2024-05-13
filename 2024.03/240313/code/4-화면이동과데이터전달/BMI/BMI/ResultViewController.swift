//
//  ResultViewController.swift
//  BMI
//
//  Created by Youngbin Choi on 3/13/24.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var BMILabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    
    var BMI: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BMILabel.text = String(format: "%.1f", BMI!)
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemGray5
        
        resetBtn.layer.cornerRadius = 10
        resetBtn.layer.masksToBounds = true
        
        BMILabel.layer.cornerRadius = 10
        BMILabel.layer.masksToBounds = true
        BMILabel.backgroundColor = getBackgroundColor(bmi: String(format: "%.1f", BMI!))
        adviceLabel.text = getBMIAdviceString(bmi: String(format: "%.1f", BMI!))
    }
    
    
    @IBAction func resetBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func getBackgroundColor(bmi: String) -> UIColor {
        let bmi = Double(bmi)!
        switch bmi {
        case ..<18.6:
            return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
        case 18.6..<23.0:
            return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
        case 23.0..<25.0:
            return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
        case 25.0..<30.0:
            return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
        case 30.0...:
            return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
        default:
            return UIColor.black
        }
    }
    
    func getBMIAdviceString(bmi: String) -> String {
        let bmi = Double(bmi)!
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "과체중"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
        }
    }

}
