//
//  Constants.swift
//  TwitterTutorial
//
//  Created by Youngbin Choi on 4/12/24.
//

import Foundation
import Firebase
import FirebaseDatabaseInternal
import FirebaseStorage

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")
