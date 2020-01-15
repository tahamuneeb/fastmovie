//
//  MovieDetailPresenter.swift
//  CIViperGenerator
//
//  Created by Taha Muneeb on 15.01.2020.
//  Copyright © 2020 Taha Muneeb. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterInterface: class {
    func pop()
}

class MovieDetailPresenter {

    unowned var view: MovieDetailViewControllerInterface
    let router: MovieDetailRouterInterface?
    let interactor: MovieDetailInteractorInterface?

    init(interactor: MovieDetailInteractorInterface, router: MovieDetailRouterInterface, view: MovieDetailViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MovieDetailPresenter: MovieDetailPresenterInterface {
    func pop() {
        router?.pop(view:view)
    }
    

}
