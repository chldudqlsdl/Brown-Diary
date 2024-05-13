//
//  SymbolRollerViewController.swift
//  SymbolRoller
//
//  Created by Youngbin Choi on 2023/10/02.
//

import UIKit

class SymbolRollerViewController: UIViewController {
    
    let symbols = ["sun.min", "moon", "cloud", "wind", "snowflake"]


    @IBOutlet weak var symbolImageView: UIImageView!
    @IBOutlet weak var symbolNameLabel: UILabel!
    @IBOutlet weak var symbolChangeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        symbolChangeButton.layer.cornerRadius = 50
        selectRandomSymbol()
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonTapped(_ sender: Any) {
        selectRandomSymbol()
    }
    
    func selectRandomSymbol() {
        let initSymbol = symbols.randomElement()!
        symbolImageView.image = UIImage(systemName: initSymbol)
        symbolNameLabel.text  = initSymbol
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
