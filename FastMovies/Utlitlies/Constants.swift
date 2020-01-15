//
//  Constants.swift
//  FastMovies
//
//  Created by Taha Muneeb on 15/01/2020.
//  Copyright © 2020 FastOrder. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static var apiKey:String = "d140b2e325f681a0b68c1a936e39df83"
    static var baseURL:String = "https://api.themoviedb.org/3/"
    static var imageURL:String = "https://image.tmdb.org/t/p/w500"
    static var placeholder:UIImage = UIImage(named: "placeholder")!
    static let mainSB:UIStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
}
