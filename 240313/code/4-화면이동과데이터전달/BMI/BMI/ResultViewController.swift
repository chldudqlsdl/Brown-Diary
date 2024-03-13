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
        BMILabel.text = String(format: "%.2f", BMI!)
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemGray5
        
        resetBtn.layer.cornerRadius = 10
        resetBtn.layer.masksToBounds = true
        
        BMILabel.layer.cornerRadius = 10
        BMILabel.layer.masksToBounds = true
        BMILabel.backgroundColor = .gray
    }
    
    
    @IBAction func resetBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    

}
