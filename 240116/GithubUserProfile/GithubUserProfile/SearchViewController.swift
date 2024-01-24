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
    
    //해야하는 것
    // setupUI
    // user model
    // bind()
    // search control
    // network
    
    @Published private var userProfile : UserProfile?
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    //Combine
    var subscription = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        embedSearchControl()
        bind()
    }
    
    func setupUI() {
        thumbnail.layer.cornerRadius = 80
    }
    
    func embedSearchControl() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search here"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    func bind() {
        //input
        
        //output
        $userProfile
            .receive(on: RunLoop.main)
            .sink { [unowned self] result in
                self.updateUser(result)
            }
            .store(in: &subscription)
    }
    
    func updateUser(_ profile : UserProfile?) {
        guard let profile = profile else{
            nameLabel.text = "n/a"
            loginLabel.text = "n/a"
            followerLabel.text = ""
            followingLabel.text = ""
            thumbnail.image = nil
            return
        }
        nameLabel.text = profile.name
        loginLabel.text = profile.login
        followerLabel.text = "followers : \(profile.followers)"
        followingLabel.text = "followers : \(profile.following)"
        let imageURL = profile.avatarUrl
        thumbnail.kf.setImage(with: imageURL)
    }
}

extension UserProfileViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text
        print("search : \(keyword)")
    }
}

extension UserProfileViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search btn clicked : \(searchBar.text)")
        
        guard let keyword = searchBar.text?.lowercased() , !keyword.isEmpty else { return }
        
        //"https://api.github.com/user/\(username)"
        
        let base = "https://api.github.com/"
        let path = "users/\(keyword)"
        //Dictionary
        let params : [String : String] = [:]
        let header : [String : String] = ["Content-Type":"application/json"]
        
        var urlComponents = URLComponents(string: base + path)!
        let queryItems = params.map { (key: String, value: String) in
            return URLQueryItem(name: key, value: value)
        }
        urlComponents.queryItems = queryItems
        
        var request = URLRequest(url: urlComponents.url!)
        header.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    let response = result.response as? HTTPURLResponse
                    let statusCode = response?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: statusCode)
                }
                return result.data
            }
            .decode(type: UserProfile.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { [unowned self]completion in
                print("completion : \(completion)")
                switch completion {
                case .failure(let error):
                    self.userProfile = nil
                case .finished: break
                }
            } receiveValue: { [unowned self] user in
                self.userProfile = user
            }
            .store(in: &subscription)
    }
    
}

