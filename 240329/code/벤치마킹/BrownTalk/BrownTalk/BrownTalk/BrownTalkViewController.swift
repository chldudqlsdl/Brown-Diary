//
//  BronwTalkViewController.swift
//  BrownTalk
//
//  Created by Youngbin Choi on 3/29/24.
//

import UIKit

class BrownTalkViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        cellRegister()
        
        tableView.dataSource = self
        
        
    }
    
    func cellRegister() {
        let xib1 = UINib(nibName: "BrownTalkTableViewCell", bundle: nil)
        tableView.register(xib1, forCellReuseIdentifier: "BrownTalkTableViewCell")
    }

}

extension BrownTalkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let roomIndex = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrownTalkTableViewCell", for: indexPath) as! BrownTalkTableViewCell
        cell.profileImageView.image = UIImage(named: chatRoomList[roomIndex].chatroomImage)
        cell.profileImageView.layer.cornerRadius = 30
        cell.profileNameView.text = chatRoomList[roomIndex].chatroomName
        cell.contentLabel.text = chatRoomList[roomIndex].chatList.last?.message
        
        let defaultToDateFormatter = DateFormatter()
        defaultToDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateToStringFormatter = DateFormatter()
        dateToStringFormatter.dateFormat = "yy.MM.dd"
        
        let lastMessage = chatRoomList[roomIndex].chatList.last?.date
        let lastMessageToDate = defaultToDateFormatter.date(from: lastMessage!)
        let dateToString = dateToStringFormatter.string(from: lastMessageToDate!)
        
        cell.dateLabel.text = dateToString
        
        return cell
    }
    
    
}

