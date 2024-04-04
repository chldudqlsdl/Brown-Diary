//
//  ViewController.swift
//  MusicApp
//
//  Created by Youngbin Choi on 4/3/24.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var musicTableView: UITableView!
    
    let searchController = UISearchController()
    
//    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    
    var musicArray : [Music] = []
    
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        setupDatas()
    }
    
    func setupSearchBar() {
        title = "음악앨범"
        navigationItem.searchController = searchController
        
        // 단순 서치바 사용
        searchController.searchBar.delegate = self
        
        // 서치 결과 컨트롤러 사용
//        searchController.searchResultsUpdater = self
        
        
    }
    
    func setupDatas() {
        networkManager.fetchMusic(searchTerm: "beenzino") { result in
            switch result {
            case .success(let musicArray) :
                self.musicArray = musicArray
                DispatchQueue.main.async {
                    self.musicTableView.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    func setupTableView() {
        musicTableView.dataSource = self
        musicTableView.delegate = self
        musicTableView.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as? MusicCell else { return UITableViewCell() }
        
        let music = musicArray[indexPath.row]
        
        cell.imageURL = music.imageUrl
        cell.songNameLabel.text = music.songName
        cell.artistNameLabel.text = music.artistName
        cell.albumNameLabel.text = music.albumName
        cell.releaseDateLabel.text = music.releaseDateString
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MainViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
//        musicArray = []
//        networkManager.fetchMusic(searchTerm: searchText) { result in
//            switch result {
//            case .success(let musicArray) :
//                self.musicArray = musicArray
//                DispatchQueue.main.async {
//                    self.musicTableView.reloadData()
//                }
//            case .failure(let error) :
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        musicArray = []
        networkManager.fetchMusic(searchTerm: text) { result in
            switch result {
            case .success(let musicArray) :
                self.musicArray = musicArray
                DispatchQueue.main.async {
                    self.musicTableView.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
}
