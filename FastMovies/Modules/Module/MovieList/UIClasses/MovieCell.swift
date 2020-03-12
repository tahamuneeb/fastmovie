//
//  MovieCell.swift
//  FastMovies
//
//  Created by Taha Muneeb on 15/01/2020.
//  Copyright © 2020 FastOrder. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var icoStar: UIImageView!
    @IBOutlet weak var imgMovie: ImageLoader!

    func setData(movie: Movie) {
        lblName.text = movie.title ?? ""
        lblYear.text = Helper.year(string: movie.releaseDate ?? "")
        lblDescription.text = movie.overview ?? ""
        lblRating.text = String(movie.voteAverage?.doubleValue ?? 0)
        if let poster = movie.posterPath {
            if let url = URL(string: Constants.imageURL + poster) {
                imgMovie.loadImage(url, placeholder: Constants.placeholder)
            } else {
                imgMovie.image = Constants.placeholder
            }
        } else {
            imgMovie.image = Constants.placeholder
        }

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
