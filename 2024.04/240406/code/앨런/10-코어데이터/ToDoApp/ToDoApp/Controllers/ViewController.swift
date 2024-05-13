//
//  ViewController.swift
//  ToDoApp
//
//  Created by Youngbin Choi on 4/6/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let coreDataManager = CoreDataManager.shared
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setupNavBar() {
        title = "메모"
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusBtnItem))
        plusButton.tintColor = .black
        navigationItem.rightBarButtonItem = plusButton
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        // 테이블뷰의 선 없애기
        tableView.separatorStyle = .none
    }

    @objc func plusBtnItem() {
        performSegue(withIdentifier: "ToDetailVC", sender: self)
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager.getToDoListFromCoreDate().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        cell.toDoData = coreDataManager.getToDoListFromCoreDate()[indexPath.row]
        cell.updateButtonPressed = { [weak self] (senderCell) in
            self?.performSegue(withIdentifier: "ToDetailVC", sender: indexPath)
            print(senderCell.dateTextLabel.text!)
        }

        cell.selectionStyle = .none
        
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "ToDetailVC", sender: indexPath)
//    }
    
    // 세그웨이 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailVC" {
            let vc = segue.destination as! DetailViewController
            
            guard let indexPath = sender as? IndexPath else { return }
            vc.toDoData = coreDataManager.getToDoListFromCoreDate()[indexPath.row]
        }
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

