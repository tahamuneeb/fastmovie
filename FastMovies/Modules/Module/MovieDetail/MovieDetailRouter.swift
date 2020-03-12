//
//  MovieDetailRouter.swift
//
//
//  Created by Taha Muneeb on 15.01.2020.
//  Copyright © 2020 Taha Muneeb. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailRouterInterface: class {
    func pop(view: MovieDetailViewControllerInterface)
}

class MovieDetailRouter: NSObject {

    weak var presenter: MovieDetailPresenterInterface?

    static func setupModule(movie: Movie?) -> MovieDetailViewController? {
        guard let viewController = Constants.mainSB.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return nil
        }
        viewController.movie = movie
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(interactor: interactor, router: router, view: viewController)

        viewController.presenter = presenter
        router.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}

extension MovieDetailRouter: MovieDetailRouterInterface {
    func pop(view: MovieDetailViewControllerInterface) {
        if let viewController = view as? UIViewController {
            viewController.navigationController?.popViewController(animated: true)
        }
    }

}
