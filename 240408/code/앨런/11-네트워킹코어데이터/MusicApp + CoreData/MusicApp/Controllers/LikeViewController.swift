//
//  LikeViewController.swift
//  MusicApp
//
//  Created by Youngbin Choi on 4/8/24.
//

import UIKit

class LikeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var musicArray : [LikedMusicData] = []
    
    let coreDataManager = CoreDataManager.shared
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "좋아요"
        setupDatas()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDatas()
        UIView.transition(with: self.tableView, duration: 5, options: .transitionCrossDissolve) {
            self.tableView.reloadData()
        }
    }
    
    func setupDatas() {
        musicArray = coreDataManager.getMusicFromCoreData()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
        tableView.dataSource = self
    }
}

extension LikeViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let music = musicArray[indexPath.row]
        if editingStyle == .delete {
            coreDataManager.deleteLikedMusic(music: music)
            musicArray = coreDataManager.getMusicFromCoreData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}



