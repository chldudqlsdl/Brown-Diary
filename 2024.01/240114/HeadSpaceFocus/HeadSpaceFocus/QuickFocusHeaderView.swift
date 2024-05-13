//
//  QuickFocusHeaderView.swift
//  HeadSpaceFocus
//
//  Created by Youngbin Choi on 1/14/24.
//

import UIKit

class QuickFocusHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var headerTitle: UILabel!
    
    func configure(_ title : String) {
        headerTitle.text = title
    }
}
