//
//  SearchDetailController.swift
//  GithubUserSearch
//
//  Created by Youngbin Choi on 1/26/24.
//

import Foundation
import UIKit
import Combine
import Kingfisher

class SearchDetailController: UIViewController {
    
    //combine
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var detailViewModel : DetailViewModel!
        
    override func viewDidLoad() {
        bind()
    }
    
    func bind() {
        detailViewModel.user
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                print("completion : \(completion)")
            }, receiveValue: { result in
                self.avatarImageView.kf.setImage(with: result.avatarUrl)
            })
            .store(in: &subscriptions)
        avatarImageView.layer.cornerRadius = 80
    }
}
