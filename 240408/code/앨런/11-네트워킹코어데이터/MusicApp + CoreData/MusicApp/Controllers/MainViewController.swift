//
//  ViewController.swift
//  MusicApp
//
//  Created by Youngbin Choi on 4/3/24.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var musicTableView: UITableView!
    
    let coreDataManager = CoreDataManager.shared
    
    // 단순한 서치 컨트롤러
//    let searchController = UISearchController()
    
    // 서치 리절트 컨트롤러
    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    
    
    var musicArray : [Music] = []
    
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        setupDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        musicTableView.reloadData()
    }
    
    func setupSearchBar() {
        title = "음악찾기"
        navigationItem.searchController = searchController
        
        // 단순 서치바 사용
//        searchController.searchBar.delegate = self
        
        // 서치 결과 컨트롤러 사용
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        
        
    }
    
    func setupDatas() {
        networkManager.fetchMusic(searchTerm: "newjeans") { result in
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
        cell.musicData = music
        
        cell.imageURL = music.imageUrl
        cell.songNameLabel.text = music.songName
        cell.artistNameLabel.text = music.artistName
        cell.albumNameLabel.text = music.albumName
        cell.releaseDateLabel.text = music.releaseDateString
        cell.isLiked = coreDataManager.LikedCheck(music: music)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? MusicCell else { return }
        cell.isLiked?.toggle()
        
        coreDataManager.saveLikedMusicData(music: cell.musicData!)
    }
    
}

//extension MainViewController: UISearchBarDelegate {
////    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
////        print(searchText)
////        musicArray = []
////        networkManager.fetchMusic(searchTerm: searchText) { result in
////            switch result {
////            case .success(let musicArray) :
////                self.musicArray = musicArray
////                DispatchQueue.main.async {
////                    self.musicTableView.reloadData()
////                }
////            case .failure(let error) :
////                print(error.localizedDescription)
////            }
////        }
////    }
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let text = searchBar.text else {
//            return
//        }
//        musicArray = []
//        networkManager.fetchMusic(searchTerm: text) { result in
//            switch result {
//            case .success(let musicArray) :
//                self.musicArray = musicArray
//                DispatchQueue.main.async {
//                    UIView.transition(
//                        with: self.musicTableView,
//                        duration: 0.5,
//                        options: .transitionCrossDissolve) {
//                        self.musicTableView.reloadData()
//                    }
//
//                }
//            case .failure(let error) :
//                print(error.localizedDescription)
//            }
//        }
//    }
//}

extension MainViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        print("서치바에 입력되는 단어 : \(searchController.searchBar.text ?? "없음")")
        
        let vc = searchController.searchResultsController as! SearchResultViewController
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
}



