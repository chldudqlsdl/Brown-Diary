//
//  File.swift
//  GhibliMembers+MVVM
//
//  Created by Youngbin Choi on 4/10/24.
//

import Foundation

protocol ManagerType {
    func getMembersList() -> [Member]
}


class MemberManager : ManagerType {
    
    var membersList : [Member] = []
    
    init() {
        makeMembersList()
    }
    
    func makeMembersList() {
        membersList = [
            Member(name: "토토로", age: 1302),
            Member(name: "하쿠", age: 13),
            Member(name: "돼지", age: 36),
            Member(name: "마히토", age: 11),
            Member(name: "치히로", age: 10),
            Member(name: "하울", age: 27),
            Member(name: "소피", age: 18),
            Member(name: "키키", age: 13),
            Member(name: "포뇨", age: 5)
        ]
    }
    
    func getMembersList() -> [Member] {
        return membersList
    }
    
}
