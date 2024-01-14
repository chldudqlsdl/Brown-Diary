//
//  FrameworkDetailViewController.swift
//  AppleFramework
//
//  Created by joonwon lee on 2022/05/01.
//

import UIKit
import SafariServices
import Combine

class FrameworkDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //Combine
    var subscriptions = Set<AnyCancellable>()
    let didTapped = PassthroughSubject<AppleFramework, Never>()
    let framework = CurrentValueSubject<AppleFramework, Never>(AppleFramework(name: "Unknown", imageName: "", urlString: "", description: ""))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        //Input
        
        didTapped
            .receive(on: RunLoop.main)
            .compactMap{ URL(string: $0.urlString) }
            .sink { [unowned self] url in
                
                let safari = SFSafariViewController(url: url)
                self.present(safari, animated: true)
        }
            .store(in: &subscriptions)
        
        //Output
        
        framework.sink { framework in
            self.imageView.image = UIImage(named: framework.imageName)
            self.titleLabel.text = framework.name
            self.descriptionLabel.text = framework.description
        }
    }
    
    
    @IBAction func learnMoreTapped(_ sender: Any) {
        didTapped.send(framework.value)
    }
}
