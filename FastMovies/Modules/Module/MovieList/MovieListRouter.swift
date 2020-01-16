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
    func pushToDetailVC(movie:Movie, view:MovieListViewControllerInterface)
}

class MovieListRouter: NSObject {

    weak var presenter: MovieListPresenterInterface?

    static func setupModule() -> MovieListViewController {
        let vc = Constants.mainSB.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        let interactor = MovieListInteractor()
        let router = MovieListRouter()
        let presenter = MovieListPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.presenter = presenter
        interactor.presenter = presenter
        return vc
    }
}

extension MovieListRouter: MovieListRouterInterface {
    func pushToDetailVC(movie: Movie, view:MovieListViewControllerInterface) {
        let v = MovieDetailRouter.setupModule(movie: movie)
        if let vc = view as? UIViewController{
            vc.navigationController?.pushViewController(v, animated: true)
        }
        
    }
    
    
    
    
    
    
    

}

