//
//  ViewController.swift
//  TableViewCode
//
//  Created by Youngbin Choi on 3/28/24.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {
    
    var movieDataManager = DataManager()
    
    private let tableView = UITableView().then {
        $0.rowHeight = 120
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        movieDataManager.makeMovieData()
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        setupTableViewConstraints()
        
        title = "영화목록"
    }
    
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDataManager.getMovieData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieData = movieDataManager.getMovieData()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MyTableViewCell
        
        cell.mainImageView.image = movieData.movieImage
        cell.movieNameLabel.text = movieData.movieName
        cell.descriptionLabel.text = movieData.movieDescription
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.movieData = movieDataManager.getMovieData()[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

