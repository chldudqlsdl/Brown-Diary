//
//  ViewController.swift
//  GhibliMembers
//
//  Created by Youngbin Choi on 4/1/24.
//

import UIKit
import Then
import SnapKit

final class MainViewController: UIViewController {
        
    let tableView = UITableView()
    
    let memberListManager = MemberListManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDatas()
        setupTableView()
        setupNavBar()
    }

    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupDatas() {
        memberListManager.makeMembersListDatas()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
    }
    
    func setupNavBar() {
        title = "회원명단"
        
        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.configureWithTransparentBackground()  // 투명으로
//        appearance.backgroundColor = .brown     // 색상설정

        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
}

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberListManager.getMembersList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell()}
        
        let member = memberListManager[indexPath.row]
        cell.member = member
//        cell.mainImageView.image = member.image
//        cell.nameLabel.text = member.name
//        cell.ageLabel.text = String(member.age ?? 0) + "세"
        cell.selectionStyle = .none
        
        return cell
    }
}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc = DetailViewController()
        vc.member = memberListManager.getMembersList()[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
