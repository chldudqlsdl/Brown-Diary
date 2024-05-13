//
//  ToDoCell.swift
//  ToDoApp
//
//  Created by Youngbin Choi on 4/6/24.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var toDoTextLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    var toDoData: ToDoData? {
        didSet {
            configureUIwithData()
        }
    }
    
    var updateButtonPressed: (ToDoCell) -> Void = { (sender) in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // 기본 UI
    func configureUI() {
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 8
        
        updateButton.clipsToBounds = true
        updateButton.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUIwithData(){
        toDoTextLabel.text = toDoData?.memoText
        dateTextLabel.text = toDoData?.dateString
        guard let colorNum = toDoData?.color else { return }
        let color = MyColor(rawValue: colorNum) ?? .red
        backView.backgroundColor = color.backgoundColor
        updateButton.backgroundColor = color.buttonColor
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        updateButtonPressed(self)
    }
    
}

