//
//  MovieListViewController.swift
//  
//
//  Created by Taha Muneeb on 15.01.2020.
//  Copyright © 2020 Taha Muneeb. All rights reserved.
//

import UIKit

protocol MovieListViewControllerInterface: class {
    func showLoading()
    func hideLoading()
    func reloadData()
    func setupInitialView()
    func moviesListFetchFailed(message:String)
    func moviesFetch(moviesList:[Movie])
}
//MARK: - MovieListViewController
class MovieListViewController: BaseVC {
    var presenter: MovieListPresenterInterface?
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var collectionView:CategoriesCollectionView!
    
    
    var refreshControl = UIRefreshControl()
    var movies:[Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.selectionDelegate = self
        presenter?.fetchMovies(type: .popular)
        
    }
    
    @objc func refresh(){
        refreshControl.endRefreshing()
    }
    
}

//MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.setData(movie: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showMovieDetail(movie: movies[indexPath.row])
    }
}
//MARK: - MovieListViewControllerInterface
extension MovieListViewController: MovieListViewControllerInterface {
    
    func moviesListFetchFailed(message: String) {
        showAlert(title: "Error", message: message, action: nil)
    }
    
    func moviesFetch(moviesList: [Movie]) {
        movies = moviesList
    }
    
    func showLoading() {
        refreshControl.beginRefreshingManually()
    }
    
    func hideLoading() {
        refreshControl.endRefreshing()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func setupInitialView() {
        
    }
}

//MARK: - CategoriesCollectionViewSelectionDelegate
extension MovieListViewController: CategoriesCollectionViewSelectionDelegate{
    func collectionViewSelected(type: MovieType) {
        presenter?.fetchMovies(type: type)
    }
}
