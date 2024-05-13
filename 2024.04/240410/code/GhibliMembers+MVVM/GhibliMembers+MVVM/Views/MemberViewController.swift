//
//  ViewController.swift
//  GhibliMembers+MVVM
//
//  Created by Youngbin Choi on 4/10/24.
//

import UIKit
import SnapKit
import Then

class MemberViewController: UIViewController {
    
    var tableView = UITableView()
    
    let viewModel : MemberListViewModel
    
    
    init(viewModel: MemberListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAutoLayout()
        setNavBar()
        setTableView()
    }
    
    // MARK: - 오토레이아웃 세팅
    func setAutoLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: - 네비게이션 바 세팅
    func setNavBar() {
        title = viewModel.title
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.rightBarButtonItem = plusButton
    }
    
    @objc func plusButtonTapped() {
        viewModel.handleNextVC(index: nil, fromCurrentVC: self)
    }
    
    // MARK: - 테이블뷰 세팅
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: "MemberTableViewCell")
    }
}

// MARK: - 데이터소스

extension MemberViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell", for: indexPath) as! MemberTableViewCell
        
        let memberVM = viewModel.memberViewModelAtIndex(index: indexPath.row)
        cell.viewModel = memberVM
        cell.selectionStyle = .none
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}

