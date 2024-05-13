//
//  FrameworkDetailViewController.swift
//  AppleFramework
//
//  Created by Youngbin Choi on 1/8/24.
//

import UIKit
import SafariServices

class FrameworkDetailViewController: UIViewController {
    
    var framework : AppleFramework = AppleFramework(name: "", imageName: "", urlString: "", description: "")

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var frameworkTitle: UILabel!
    @IBOutlet weak var frameworkDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thumbnail.image = UIImage(named: framework.imageName)
        frameworkTitle.text = framework.name
        frameworkDescription.text = framework.description
    }
    
    
    @IBAction func webLinkButtonTapped(_ sender: Any) {
        guard let url = URL(string: framework.urlString) else {
            return
        }
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }
    
}
