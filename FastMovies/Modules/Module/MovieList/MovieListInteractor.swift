//
//  MovieListInteractor.swift
//  CIViperGenerator
//
//  Created by Taha Muneeb on 15.01.2020.
//  Copyright © 2020 Taha Muneeb. All rights reserved.
//

import Foundation

enum MovieType:String{
    case popular = "discover/movie?sort_by=popularity.desc"
    case topRated = "discover/movie?sort_by=vote_average.desc"
    case upComing = "discover/movie?primary_release_date.gte"
}

protocol MovieListInteractorInterface: class {
    func fetchMovies(type:MovieType)
}

class MovieListInteractor {
    
    weak var presenter: MovieListPresenterInterface?
}

extension MovieListInteractor: MovieListInteractorInterface {
    func fetchMovies(type:MovieType){
        var urlString = Constants.baseURL
        if type == .upComing{
            urlString += "\(type.rawValue)=\(Date().movieFilterDate())"
        }else{
            urlString += "\(type.rawValue)"
        }
        urlString += "&api_key=\(Constants.apiKey)"
        print("URL -> \(urlString)")
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let err = error{
                self.presenter?.moviesListFetchFailed(with: err.localizedDescription)
            }else{
                let jsonDecoder = JSONDecoder()
                do{
                   let responseModel = try jsonDecoder.decode(MovieListResponse.self, from: data!)
                    DispatchQueue.main.async {
                        self.presenter?.moviesListFetched(moviesList: responseModel)
                    }
                   
                }catch let e {
                    DispatchQueue.main.async {
                        self.presenter?.moviesListFetchFailed(with: e.localizedDescription)
                    }
                }
            }

        }
        
        task.resume()
        
    }
}
