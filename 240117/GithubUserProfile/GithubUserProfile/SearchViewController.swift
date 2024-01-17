//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import UIKit
import Combine
import Kingfisher

class UserProfileViewController: UIViewController {
    
    // 초기 UI
    // bind()
    // Search Bar
    // UserProfile model
    
    // Network
    let network = NetworkService(configuration: URLSessionConfiguration.default)
    
    // Combine
    @Published private var userProfile : UserProfile?
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        embedSearchbar()
        bind()
        
    }
    
    private func updateUI() {
        thumbnail.layer.cornerRadius = 80
    }
    
    private func embedSearchbar() {
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search by Github ID"
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
    }
    
    private func bind() {
        //Input
        
        //Output
        $userProfile
            .receive(on: RunLoop.main)
            .sink { [unowned self] profile in
                self.bindingUI(profile)
            }
            .store(in: &subscriptions)
    }
    
    private func bindingUI(_ userProfile : UserProfile?) {
        
        guard let userProfile = userProfile else {
            
            nameLabel.text = "n/a"
            loginLabel.text = "n/a"
            followerLabel.text = ""
            followingLabel.text = ""
            thumbnail.image = nil
            return
        }
        nameLabel.text = userProfile.name
        loginLabel.text = userProfile.login
        followerLabel.text = "follower : \(userProfile.followers)"
        followingLabel.text = "following : \(userProfile.following)"
        thumbnail.kf.setImage(with: userProfile.avatarUrl)
    }
}

extension UserProfileViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}

extension UserProfileViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let keyword = searchBar.text?.lowercased() , !keyword.isEmpty else {
            return
        }
        
        let resource = Resource<UserProfile>(
            base: "https://api.github.com/",
            path: "users/\(keyword)",
            params: [:],
            header: ["Content-Type":"application/json"]
        )
        
//        let base = "https://api.github.com/"
//        let path = "users/\(keyword)"
//        let params : [String : String] = [:]
//        let header : [String : String] = ["Content-Type":"application/json"]
//        
//        var urlComponents = URLComponents(string: base + path)!
//        let queryItems = params.map { (key: String, value: String) in
//            return URLQueryItem(name: key, value: value)
//        }
//        urlComponents.queryItems = queryItems
//        
//        var urlRequest = URLRequest(url: urlComponents.url!)
//        header.forEach { (key: String, value: String) in
//            urlRequest.addValue(value, forHTTPHeaderField: key)
//        }
        
        network.load(resource)
            .receive(on: RunLoop.main)
            .sink { [unowned self]completion in
                switch completion {
                case .finished : break
                case .failure(let error) :
                    self.userProfile = nil
                    print(error)
                }
            } receiveValue: { userProfile in
                self.userProfile = userProfile
            }.store(in: &subscriptions)

        
        
//        URLSession.shared
//            .dataTaskPublisher(for: urlRequest)
//            .tryMap { result in
//                guard let httpResponse = result.response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
//                    let httpResponse = result.response as? HTTPURLResponse
//                    let statusCode = httpResponse?.statusCode ?? -1
//                    throw NetworkError.responseError(statusCode: statusCode)
//                }
//                return result.data
//            }
//            .decode(type: UserProfile.self, decoder: JSONDecoder())
//            .receive(on: RunLoop.main)
//            .sink { [unowned self] completion in
//                switch completion {
//                case .finished : break
//                case .failure(let error) :
//                    self.userProfile = nil
//                    print(error)
//                }
//            } receiveValue: { userProfile in
//                self.userProfile = userProfile
//            }
//            .store(in: &subscriptions)
    }
}
