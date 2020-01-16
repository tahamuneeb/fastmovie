//
//  MovieListPresenter.swift
//  
//
//  Created by Taha Muneeb on 15.01.2020.
//  Copyright © 2020 Taha Muneeb. All rights reserved.
//

import Foundation
import UIKit

protocol MovieListPresenterInterface: class {
    
    // View -> Presenter
    func fetchMovies(type:MovieType)
    func showMovieDetail(movie: Movie)
    
    
    // Interactor -> Presenter
    func moviesListFetched(moviesList:MovieListResponse)
    func moviesListFetchFailed(with errorMessage:String)
}

class MovieListPresenter {

    unowned var view: MovieListViewControllerInterface
    let router: MovieListRouterInterface?
    let interactor: MovieListInteractorInterface?

    init(interactor: MovieListInteractorInterface, router: MovieListRouterInterface, view: MovieListViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    
}

extension MovieListPresenter: MovieListPresenterInterface {
    func showMovieDetail(movie: Movie) {
        router?.pushToDetailVC(movie: movie, view: view)
    }
    
    func fetchMovies(type: MovieType) {
        view.showLoading()
        self.interactor?.fetchMovies(type: type)
    }
    
    func moviesListFetched(moviesList: MovieListResponse) {
        view.hideLoading()
        if let data = moviesList.results{
            view.moviesFetch(moviesList: data)
        }
        view.reloadData()
    }
    
    func moviesListFetchFailed(with errorMessage: String) {
        view.hideLoading()
        view.moviesListFetchFailed(message: errorMessage)
        
    }
}
