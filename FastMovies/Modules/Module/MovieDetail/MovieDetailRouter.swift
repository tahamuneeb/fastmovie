//
//  MovieDetailRouter.swift
//  CIViperGenerator
//
//  Created by Taha Muneeb on 15.01.2020.
//  Copyright © 2020 Taha Muneeb. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailRouterInterface: class {
    func pop(view:MovieDetailViewControllerInterface)
}

class MovieDetailRouter: NSObject {

    weak var presenter: MovieDetailPresenterInterface?

    static func setupModule(movie:Movie?) -> MovieDetailViewController {
        let vc = Constants.mainSB.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        vc.movie = movie
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.presenter = presenter
        interactor.presenter = presenter
        return vc
    }
}

extension MovieDetailRouter: MovieDetailRouterInterface {
    func pop(view:MovieDetailViewControllerInterface) {
        if let vc = view as? UIViewController{
            vc.navigationController?.popViewController(animated: true)
        }
    }
    

}

