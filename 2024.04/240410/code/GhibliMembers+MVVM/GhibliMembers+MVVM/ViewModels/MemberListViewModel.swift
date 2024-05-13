//
//  MemberViewModel.swift
//  GhibliMembers+MVVM
//
//  Created by Youngbin Choi on 4/10/24.
//

import Foundation
import UIKit

class MemberListViewModel {
    
    let dataManager : ManagerType
    
    let title : String
    
    var membersList : [Member] {
        return dataManager.getMembersList()
    }
    
    init(dataManager: ManagerType, title: String) {
        self.dataManager = dataManager
        self.title = title
    }
    
    // MARK: - Output
    
    var numberOfRowsInSection : Int {
        return membersList.count
    }
    
    // MARK: - ViewModel 생성
    func memberViewModelAtIndex(index: Int) -> MemberViewModel {
        let member = membersList[index]
        return MemberViewModel(dataManager: dataManager, member: member, index: index)
    }
    
    // MARK: - Logic
    func handleNextVC(index: Int?, fromCurrentVC: UIViewController) {
        if let index = index {
            
        } else {
            let newVM = MemberViewModel(dataManager: self.dataManager, member: nil, index: nil)
            goToNextVC(memberVM: newVM, fromCurrentVC: fromCurrentVC)
        }
    }
    
    func goToNextVC(memberVM: MemberViewModel ,fromCurrentVC : UIViewController) {
        
        let navVC = fromCurrentVC.navigationController
        
        let detailVC = DetailViewController(viewModel: memberVM)
        navVC?.pushViewController(detailVC, animated: true)
    }
}
