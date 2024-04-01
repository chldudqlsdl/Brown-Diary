//
//  DetailViewController.swift
//  GhibliMembers
//
//  Created by Youngbin Choi on 4/1/24.
//

import UIKit
import Then
import SnapKit

class DetailViewController: UIViewController {
    
    let detailView = DetailView()
    
    var member : Member?
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "비상연락망"
        
        setupButtonAction()
        setMemberDatas()
    }
    
    func setupButtonAction() {
        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        print("버튼이 눌렸습니다")
        
        if member == nil {
            let name = detailView.nameTextField.text ?? ""
            let age = Int(detailView.ageTextField.text ?? "")
            
            var newMember = Member(name: name, age: age)
            newMember.image = detailView.imageView.image
            
        } else {
            
            member!.image = detailView.imageView.image
            
            let memberId = Int(detailView.idTextField.text!) ?? 0
            member!.name = detailView.nameTextField.text ?? ""
            member!.age = Int(detailView.ageTextField.text ?? "")
            
            // 델리게이트 아닌 방식으로 구현
            let index = navigationController!.viewControllers.count - 2
            let vc = navigationController?.viewControllers[index] as! MainViewController
            vc.memberListManager.updateMemberInfo(index: memberId, member!)
            
        }
    }
    
    func setMemberDatas() {
        detailView.member = member
    }
}

