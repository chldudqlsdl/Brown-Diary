//
//  ViewController.swift
//  SimpleWeather
//
//  Created by Youngbin Choi on 10/4/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let cities = ["Seoul", "Berlin", "New York", "London", "Paris"]
    let weathers = ["cloud.fill", "sun.max.fill", "wind", "cloud.sun.rain.fill"]
    
    
    @IBAction func changeButtonTapped(_ sender: Any) {
        cityLabel.text = cities.randomElement()
        weatherImageView.image = UIImage(systemName: weathers.randomElement()!)?.withRenderingMode(.alwaysOriginal)
        temperatureLabel.text = "\(Int.random(in: 10..<30))°"
    }
    

}

