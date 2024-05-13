//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    // SearchController
    // bind()
    // CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Combine
    @Published var users : [SearchResult] = []
    var subscriptions = Set<AnyCancellable>()
    let network = NetworkService(configuration: .default)
    
    // CollectionView
    enum Section {
        case main
    }
    typealias Item = SearchResult
    
    var dataSource : UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedSearchControl()
        configureCollectionView()
        bind()
    }
    
    private func embedSearchControl() {
        
        self.navigationItem.title = "Search"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Find people"
        
        searchController.searchResultsUpdater  = self
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
    }
    
    private func configureCollectionView() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        collectionView.collectionViewLayout = layout()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func bind() {
        $users.receive(on: RunLoop.main)
            .sink { users in
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])
                snapshot.appendItems(users, toSection: .main)
                self.dataSource.apply(snapshot)
            }.store(in: &subscriptions)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
        
        guard let keyword = searchController.searchBar.text, !keyword.isEmpty else { return }
        
        let base = "https://api.github.com/"
        let path = "search/users"
        let params : [String : String] = ["q":keyword]
        let header : [String : String] = ["Content-Type":"application/json"]
        
        let resource = Resource<SearchUserResponse>(base: base, path: path, params: params, header: header)
        
        network
            .load(resource)
            .sink { completion in
                print(completion)
            } receiveValue: { result in
                self.users = result.items
            }
            .store(in: &subscriptions)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text)
        
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        
        let base = "https://api.github.com/"
        let path = "search/users"
        let params : [String : String] = ["q":keyword]
        let header : [String : String] = ["Content-Type":"application/json"]
        
        let resource = Resource<SearchUserResponse>(base: base, path: path, params: params, header: header)
        
//        let base = "https://api.github.com/"
//        let path = "search/users"
//        let params : [String : String] = ["q":keyword]
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
        
        network
            .load(resource)
            .sink { completion in
                print(completion)
            } receiveValue: { result in
                self.users = result.items
            }
            .store(in: &subscriptions)


//            .map{$0.items}
//            .replaceError(with: [])
//            .assign(to: \.users, on: self)
//            .store(in: &subscriptions)
            
//        URLSession.shared.dataTaskPublisher(for: urlRequest)
//            .map {$0.data}
//            .decode(type: SearchUserResponse.self, decoder: JSONDecoder())
//            .map {$0.items}
//            .replaceError(with: [])
//            .receive(on: RunLoop.main)
//            .assign(to: \.users, on: self)
//            .store(in: &subscriptions)
    }
}
