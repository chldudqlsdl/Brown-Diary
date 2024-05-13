//
//  StockRankCollectionViewCell.swift
//  StockRank
//
//  Created by Youngbin Choi on 10/5/23.
//

import UIKit

class StockRankCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var companyPriceLabel: UILabel!
    @IBOutlet weak var diffLabel: UILabel!
    @IBOutlet weak var companyIconImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    func configure(_ stock: StockModel) {
        rankLabel.text = "\(stock.rank)"
        companyPriceLabel.text = "\(convertToCurrencyFormat(price: stock.price)) 원"
        diffLabel.text = "\(stock.diff) %"
        companyIconImageView.image = UIImage(named: "\(stock.imageName)")
        companyNameLabel.text = "\(stock.name)"
        diffLabel.textColor = stock.diff > 0 ? .systemRed : .systemBlue
        likeImage.tintColor = .lightGray
    }
    
    func convertToCurrencyFormat(price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        let result = numberFormatter.string(from: NSNumber(value: price))!
        return result
    }
    @IBAction func hearButtonTapped(_ sender: Any) {
        if likeImage.tintColor == .lightGray {
            likeImage.tintColor = .systemRed
        } else {
            likeImage.tintColor = .lightGray
        }
    }
    
}
