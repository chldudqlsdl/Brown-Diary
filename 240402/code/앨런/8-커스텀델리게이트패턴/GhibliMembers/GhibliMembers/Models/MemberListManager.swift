//
//  MemberListManager.swift
//  GhibliMembers
//
//  Created by Youngbin Choi on 4/1/24.
//

import Foundation

final class MemberListManager {
    
    private var membersList: [Member] = []
    
    // 이후에 네크워크 통신을 할 때 이런 방식을 주로 사용함
    func makeMembersListDatas() {
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
    
    // 멤버 리스트 받기
    func getMembersList() -> [Member] {
        return membersList
    }
    
    // 새로운 멤버 만들기
    func makeNewMember(_ member: Member) {
        membersList.append(member)
    }
    
    // 기존 멤버 정보 업데이트
    func updateMemberInfo(index: Int, _ member: Member) {
        membersList[index] = member
    }
    
    // 특정 멤버 얻기(서브스크립트 구현해보기)
    subscript(index: Int) -> Member {
        get {
            return membersList[index]
        }
//        set {
//            membersList[index] = newValue
//        }
    }
}
