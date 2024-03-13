//
//  ViewController.swift
//  BMI
//
//  Created by Youngbin Choi on 3/13/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var calculateBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        heightTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        weightTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
    }
    
    func configureUI() {
        view.backgroundColor = .systemGray5
        calculateBtn.layer.cornerRadius = 10
        calculateBtn.layer.masksToBounds = true
        calculateBtn.isEnabled = false
        calculateBtn.backgroundColor = .gray
        heightTextField.placeholder = "cm 단위로 입력해주세요"
        weightTextField.placeholder = "kg 단위로 입력해주세요"
        heightTextField.layer.cornerRadius = 5
        heightTextField.layer.masksToBounds = true
        weightTextField.layer.cornerRadius = 5
        weightTextField.layer.masksToBounds = true
        heightTextField.returnKeyType = .go
        weightTextField.returnKeyType = .go
    }
    
    @IBAction func calculateBtnTapped(_ sender: Any) {
        let resultVC = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        resultVC.BMI = Float(weightTextField.text!)! / (Float(heightTextField.text!)!/100 * Float(heightTextField.text!)!/100 )
        present(resultVC, animated: true) {
            self.heightTextField.text = ""
            self.weightTextField.text = ""
        }
    }
    
    @objc func textFieldChanged(tf:UITextField){
        if tf.text?.count == 1 {
            if tf.text?.first == " " {
                tf.text = ""
                return
            }
        }
        guard
            let height = heightTextField.text, !height.isEmpty,
            let weight = weightTextField.text, !weight.isEmpty
        else {
            calculateBtn.backgroundColor = .gray
            calculateBtn.isEnabled = false
            return
        }
        calculateBtn.backgroundColor = .systemBlue
        calculateBtn.isEnabled = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil || string == "" {
            return true
        }
        return false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
}



