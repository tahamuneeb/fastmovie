//
//  MovieDetailViewController.swift
//  
//
//  Created by Taha Muneeb on 15.01.2020.
//  Copyright © 2020 Taha Muneeb. All rights reserved.
//

import UIKit

protocol MovieDetailViewControllerInterface: class {

}

class MovieDetailViewController: BaseVC {
    var presenter: MovieDetailPresenterInterface?

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var icoStar: UIImageView!
    @IBOutlet weak var imgMovie: ImageLoader!

    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        setMovie()
    }

    func setMovie() {
        // set movie details
        if let mov = movie {
            lblName.text = mov.title ?? ""
            lblYear.text = Helper.year(string: mov.releaseDate ?? "")
            tvDescription.text = mov.overview ?? ""
            lblRating.text = String(mov.voteAverage?.doubleValue ?? 0)
            if let poster = mov.posterPath {
                if let url = URL(string: Constants.imageURL + poster) {
                    imgMovie.loadImage(url, placeholder: Constants.placeholder)
                } else {
                    imgMovie.image = Constants.placeholder
                }
            } else {
                imgMovie.image = Constants.placeholder
            }
        }
    }

    @IBAction func pop(_ sender: UIButton) {
        presenter?.pop()
    }
}

extension MovieDetailViewController: MovieDetailViewControllerInterface {

}
