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
    
    // UI 작업
    // bind() -> Input, Output
    // SearchControl
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    // Combine
    var user = CurrentValueSubject<UserProfile?, Error>(nil)
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        embedSearchController()
        bind()
    }
    
    func updateUI() {
        thumbnail.layer.cornerRadius = 80
    }
    
    func embedSearchController() {
        
        self.navigationItem.title = "Search"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Github ID"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
    }
    
    func bind() {
        // Outout
        user
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [unowned self] profile in
                self.updateUser(profile)
            }
            .store(in: &subscriptions)
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

extension UserProfileViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search btn clicked : \(searchBar.text)")
        // Input
        guard let keyword = searchBar.text?.lowercased(),  !keyword.isEmpty else { return }
        
        let networkservice = NetworkService(configuration: .default)
        let resource = Resource<UserProfile>(base: "https://api.github.com/", path: "users/\(keyword)")
        networkservice
            .load(resource)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished :
                    break
                case .failure(let error) :
                    self.user.send(nil)
                    print(error)
                }
            } receiveValue: { profile in
                self.user.send(profile)
            }
            .store(in: &subscriptions)
        
//        let base = "https://api.github.com/"
//        let path = "users/\(keyword)"
//        let params : [String : String] = [:]
//        let header : [String : String] = ["Content-Type": "application/json"]
//        
//        var urlComponents = URLComponents(string: base + path)!
//        let queryItems = params.map { (key: String, value: String) in
//            URLQueryItem(name: key, value: value)
//        }
//        urlComponents.queryItems = queryItems
//        
//        var urlRequest = URLRequest(url: urlComponents.url!)
//        header.forEach { (key: String, value: String) in
//            urlRequest.addValue(value, forHTTPHeaderField: key)
//        }
//        
//        URLSession.shared.dataTaskPublisher(for: urlRequest)
//            .tryMap { result in
//                guard let httpResponse = result.response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
//                    let httpResponse = result.response as? HTTPURLResponse
//                    throw NetworkError.responseError(statusCode: httpResponse?.statusCode ?? -1)
//                }
//                return result.data
//            }
//            .decode(type: UserProfile.self, decoder: JSONDecoder())
//            .receive(on: RunLoop.main)
//            .sink { completion in
//                switch completion {
//                case .finished :
//                    print("finished")
//                    break
//                case .failure(let error) :
//                    self.user.send(nil)
//                    print("error")
//                }
//                print("completion : \(completion)")
//            } receiveValue: { profile in
//                self.user.value = profile
//            }
//            .store(in: &subscriptions)

    }
}
