//
//  MovieDetailInteractor.swift
//  CIViperGenerator
//
//  Created by Taha Muneeb on 15.01.2020.
//  Copyright © 2020 Taha Muneeb. All rights reserved.
//

import Foundation

protocol MovieDetailInteractorInterface: class {

}

class MovieDetailInteractor {
    weak var presenter: MovieDetailPresenterInterface?
}

extension MovieDetailInteractor: MovieDetailInteractorInterface {

}
