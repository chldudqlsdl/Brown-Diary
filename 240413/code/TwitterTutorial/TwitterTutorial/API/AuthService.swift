//
//  AuthService.swift
//  TwitterTutorial
//
//  Created by Youngbin Choi on 4/13/24.
//

import Foundation
import FirebaseAuth
import UIKit
import FirebaseDatabaseInternal

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    private init() {}
    
    func logUserIn(withEmail email: String, withPassword password: String, completion: @escaping (AuthDataResult?, Error?) -> Void ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(authCredentials: AuthCredentials, completion: @escaping (Error?, DatabaseReference) -> Void) {
        
        let email = authCredentials.email
        let password = authCredentials.password
        let fullName = authCredentials.fullName
        let username = authCredentials.username
        
        guard let imageData = authCredentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let fileName = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(fileName)
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            storageRef.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let values = ["email": email, "username": username, "fullname": fullName, "profileImageUrl": profileImageUrl]
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock:  completion)
                }
            }
        }
    }
}
