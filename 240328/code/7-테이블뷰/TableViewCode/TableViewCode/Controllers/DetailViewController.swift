//
//  DetailViewController.swift
//  TableViewCode
//
//  Created by Youngbin Choi on 3/28/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    
    var movieData : Movie?
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        detailView.mainImageView.image = movieData?.movieImage
        detailView.movieNameLabel.text = movieData?.movieName
        detailView.descriptionLabel.text = movieData?.movieDescription

    }
}
