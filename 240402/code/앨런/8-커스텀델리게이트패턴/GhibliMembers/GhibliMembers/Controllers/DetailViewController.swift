//
//  DetailViewController.swift
//  GhibliMembers
//
//  Created by Youngbin Choi on 4/1/24.
//

import UIKit
import Then
import SnapKit
import PhotosUI

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
        setupTapGestures()
    }
    
    func setupButtonAction() {
        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        print("버튼이 눌렸습니다")
        
        if member == nil {
            let name = detailView.nameTextField.text ?? ""
            let age = Int(detailView.ageTextField.text ?? "")
            
            let newMember = Member(name: name, age: age)
            newMember.image = detailView.imageView.image
            
            let index = navigationController!.viewControllers.count - 2
            let vc = navigationController!.viewControllers[index] as! MainViewController
            vc.memberListManager.makeNewMember(newMember)
            
            
        } else {
            
            member!.image = detailView.imageView.image
            let memberId = Int(detailView.idTextField.text!) ?? 0
            member!.name = detailView.nameTextField.text ?? ""
            member!.age = Int(detailView.ageTextField.text ?? "")
            
            // 델리게이트 아닌 방식으로 구현
            let index = navigationController!.viewControllers.count - 2
            let vc = navigationController!.viewControllers[index] as! MainViewController
            vc.memberListManager.updateMemberInfo(index: memberId, member!)
            
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func setMemberDatas() {
        detailView.member = member
    }
    
    func setupImagePicker() {
        
        //기본설정 셋팅
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images, .videos])
        
        // 컨트롤러 설정
        let pickerController = PHPickerViewController(configuration: configuration)
        pickerController.delegate = self
        
        // 피커뷰 띄우기
        self.present(pickerController, animated: true)
    }
    
    
    // MARK: - 이미지뷰가 눌렸을 때 동작설정
    
    func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpImageView))
        detailView.imageView.addGestureRecognizer(tapGesture)
        detailView.imageView.isUserInteractionEnabled = true
    }
    
    @objc func touchUpImageView() {
        print("이미지뷰 터치")
        setupImagePicker()
    }

}

extension DetailViewController : PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider , itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.detailView.imageView.image = image as? UIImage
                }
            }
        } else {
            print("이미지를 못 불러왔습니다!")
        }
    }
}
