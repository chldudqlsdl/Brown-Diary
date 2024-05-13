//
//  SymbolRollerViewController.swift
//  SymbolRoller
//
//  Created by Youngbin Choi on 1/3/24.
//

import UIKit

class SymbolRollerViewController: UIViewController {
    
    let symbols: [String] = [
    "sun.min", "moon", "cloud", "wind", "snowflake"
    ]
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    func pickRandomImage() -> String {
        return symbols.randomElement()!
    }
    
    func reload() {
        let symbol = symbols.randomElement()!
        imageView.image = UIImage(systemName: symbol)
        label.text = symbol
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }

    @IBAction func buttonTapped(_ sender: Any) {
       reload()
    }
}
