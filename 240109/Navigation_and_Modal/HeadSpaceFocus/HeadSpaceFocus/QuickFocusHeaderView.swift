//
//  QuickFocusHeaderView.swift
//  HeadSpaceFocus
//
//  Created by Youngbin Choi on 1/9/24.
//

import UIKit

class QuickFocusHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var headerLabel: UILabel!
    
    func configure(_ title : String) {
        headerLabel.text = title
    }
}
