//
//  Member.swift
//  GhibliMembers+MVVM
//
//  Created by Youngbin Choi on 4/10/24.
//

import Foundation
import UIKit

struct Member {
    
    static var memberNumbers : Int = 0
    
    let memberId : Int
    let name : String?
    let age: Int?
    
    lazy var image : UIImage? = {
        return UIImage(named: name!)!
    }()
    
    init(name: String?, age: Int?) {
        self.memberId = Member.memberNumbers
        self.name = name
        self.age = age
        
        Member.memberNumbers += 1
    }
    
}
