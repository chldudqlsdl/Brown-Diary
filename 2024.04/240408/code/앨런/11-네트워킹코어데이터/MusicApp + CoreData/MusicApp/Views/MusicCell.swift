//
//  MusicCell.swift
//  MusicApp
//
//  Created by Youngbin Choi on 4/4/24.
//

import UIKit

final class MusicCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    var imageURL: String? {
        didSet {
            loadImage()
        }
    }
    
    var isLiked: Bool? = false {
        didSet {
            setLikeImage()
        }
    }
        
    var musicData: Music?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageView.contentMode = .scaleToFill
        mainImageView.layer.cornerRadius = 5
        mainImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func loadImage() {
        
        guard let urlString = imageURL, let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard self.imageURL! == url.absoluteString else { return }
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func setLikeImage() {
        let redHeart = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        likeImage.image = isLiked! ? redHeart : UIImage(systemName: "heart")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // 일반적으로 이미지가 바뀌는 것처럼 보이는 현상을 없애기 위해서 실행 ⭐️
        self.mainImageView.image = nil
    }
}


