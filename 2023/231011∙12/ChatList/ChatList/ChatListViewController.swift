//
//  ChatListViewController.swift
//  ChatList
//
//  Created by Youngbin Choi on 10/11/23.
//

import UIKit

class ChatListViewController: UIViewController {
    
    var chatList = Chat.list

    @IBOutlet weak var chatListViewController: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatListViewController.dataSource = self
        chatListViewController.delegate = self
        
        chatList = chatList.sorted(by: { chat1, chat2 in
            return chat1.date > chat2.date
        })
    }
}

extension ChatListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = chatListViewController.dequeueReusableCell(withReuseIdentifier: "ChatListCollectionViewCell", for: indexPath) as? ChatListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let chat = chatList[indexPath.item]
        cell.configure(chat)
        return cell
    }
}

extension ChatListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: chatListViewController.bounds.width, height: 100)
    }
}

