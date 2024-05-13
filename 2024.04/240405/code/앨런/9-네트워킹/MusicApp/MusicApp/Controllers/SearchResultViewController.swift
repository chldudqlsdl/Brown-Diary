//
//  SearchResultViewController.swift
//  MusicApp
//
//  Created by Youngbin Choi on 4/5/24.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var flowLayout = UICollectionViewFlowLayout()
    
    let networkManager = NetworkManager.shared
    
    var musicArray : [Music] = []
    
    var searchTerm : String? {
        didSet {
            setupDatas()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        flowLayout.scrollDirection = .vertical
        
        let collectionCellWidth = (UIScreen.main.bounds.width - (CVCell.spacingWitdh * (CVCell.cellColumns - 1))) / CVCell.cellColumns
        
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        
        flowLayout.minimumInteritemSpacing = CVCell.spacingWitdh
        
        flowLayout.minimumLineSpacing = CVCell.spacingWitdh
        
        collectionView.collectionViewLayout = flowLayout
        
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
    }
    
    func setupDatas() {
        guard let term = searchTerm else { return }
        
        musicArray = []
        
        networkManager.fetchMusic(searchTerm: term) { result in
            switch result {
            case .success(let musicArray) :
                self.musicArray = musicArray
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }

}

extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.musicCollectionViewCellIdentifier, for: indexPath) as! MusicCollectionViewCell
        let music = musicArray[indexPath.row]
        cell.imageURL = music.imageUrl
        return cell
    }
    
    
}

