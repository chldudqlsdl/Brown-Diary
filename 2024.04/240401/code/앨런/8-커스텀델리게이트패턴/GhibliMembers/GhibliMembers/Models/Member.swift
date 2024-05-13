//
//  Member.swift
//  GhibliMembers
//
//  Created by Youngbin Choi on 4/1/24.
//

import Foundation
import UIKit

class Member {
    
    // 멤버의 절대적 순서를 위한 타입 저장 속성
    static var memberNumbers: Int = 0
    
    let memberId : Int
    var name : String?
    var age : Int?
    
    // 멤버의 이름이 없거나, 해당 이름의 사진이 없으면 더미이미지
    lazy var image: UIImage? = {
        guard let name = name else {
            return UIImage(systemName: "person")!
        }
        return UIImage(named: name) ?? UIImage(systemName: "person")!
    }()
    
    init(name: String?, age: Int?) {
        
        self.memberId = Member.memberNumbers
        self.name = name
        self.age = age
        
        Member.memberNumbers += 1
    }
}
