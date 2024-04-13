//
//  User.swift
//  TwitterTutorial
//
//  Created by Youngbin Choi on 4/13/24.
//

import Foundation

struct User {
    let uid: String
    let email: String
    let fullname: String
    let username: String
    var profileImageUrl: URL?
    
    init(uid:String, dictionary: [String: AnyObject]){
        self.uid = uid
        
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        
        if let profileImageUrl = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrl) else { return }
            self.profileImageUrl = url
        }
    }
}
