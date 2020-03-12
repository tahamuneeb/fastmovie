//
//  MovieListRouter.swift
//  
//
//  Created by Taha Muneeb on 15.01.2020.
//  Copyright © 2020 Taha Muneeb. All rights reserved.
//

import Foundation
import UIKit

protocol MovieListRouterInterface: class {
    func pushToDetailVC(movie: Movie, view: MovieListViewControllerInterface)
}

class MovieListRouter: NSObject {

    weak var presenter: MovieListPresenterInterface?

    static func setupModule() -> MovieListViewController? {
        guard let viewCtrl = Constants.mainSB.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController else {
            return nil
        }
        let interactor = MovieListInteractor()
        let router = MovieListRouter()
        let presenter = MovieListPresenter(interactor: interactor, router: router, view: viewCtrl)

        viewCtrl.presenter = presenter
        router.presenter = presenter
        interactor.presenter = presenter
        return viewCtrl
    }
}

extension MovieListRouter: MovieListRouterInterface {
    func pushToDetailVC(movie: Movie, view: MovieListViewControllerInterface) {
        let viewController = MovieDetailRouter.setupModule(movie: movie)
        if let detailVC = view as? UIViewController, let controller = viewController {
            detailVC.navigationController?.pushViewController(controller, animated: true)
        }

    }

}
