//
//  MemberViewModel.swift
//  GhibliMembers+MVVM
//
//  Created by Youngbin Choi on 4/10/24.
//

import Foundation
import UIKit

class MemberViewModel {
    
    let dataManager : ManagerType
    
    var member : Member?
    let index : Int?
    
    init(dataManager: ManagerType, member: Member?, index: Int?) {
        self.dataManager = dataManager
        self.member = member
        self.index = index
    }
    
    // MARK: - Output
    
    var memberImage : UIImage? {
        member?.image
    }
    
    var memberName : String? {
        member?.name
    }
    
    var memberAge : String? {
        member != nil ? String(member!.age!) : ""
    }
}
