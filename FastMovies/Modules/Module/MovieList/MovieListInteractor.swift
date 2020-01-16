//
//  MovieListInteractor.swift
//  
//
//  Created by Taha Muneeb on 15.01.2020.
//  Copyright © 2020 Taha Muneeb. All rights reserved.
//

import Foundation
import CoreData

// Movie filter type
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
        
        if Reachability.isConnectedToNetwork(){
            //Get Movies from server
            getMoviesFromServer(type:type)
        }else{
            //Get Movies from Local Storage
            let movies = fetchFromStorage(type:type)
            var resp = MovieListResponse()
            resp.results = movies
            presenter?.moviesListFetched(moviesList: resp)
        }
        
        
        
        
    }
    
    func getMoviesFromServer(type:MovieType){
        var urlString = Constants.baseURL
        if type == .upComing{
            urlString += "\(type.rawValue)=\(Date().movieFilterDate())"
        }else{
            urlString += "\(type.rawValue)"
        }
        urlString += "&api_key=\(Constants.apiKey)"
        print("URL -> \(urlString)")
        guard let url = URL(string: urlString) else {return}
        
        //Api Call
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let err = error{
                self.presenter?.moviesListFetchFailed(with: err.localizedDescription)
            }else{
                guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                    fatalError("Failed to retrieve managed object context")
                }
                let managedObjectContext = SingleTon.shared.cdContext
                self.clearStorage(type: type)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                do{
                    if let d = data{
                        let responseModel = try jsonDecoder.decode(MovieListResponse.self, from: d )
                        if let movies = responseModel.results{
                            for movie in movies{
                                movie.setType(type: type)
                            }
                        }
                        
                        self.saveToStorage(type: type)
                        DispatchQueue.main.async {
                            self.presenter?.moviesListFetched(moviesList: responseModel)
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.presenter?.moviesListFetchFailed(with: "No Records Found")
                        }
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
    
    func clearStorage(type:MovieType) {
        // Delete previous locally saved movies to replace with new ones
        let isInMemoryStore = SingleTon.shared.storeDescriptions.reduce(false) {
            return $0 ? true : $1.type == NSInMemoryStoreType
        }

        let managedObjectContext = SingleTon.shared.cdContext!
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate.init(format: "type=%@", type.rawValue)
        // NSBatchDeleteRequest is not supported for in-memory stores
        if isInMemoryStore {
            do {
                let movies = try managedObjectContext.fetch(fetchRequest)
                for movie in movies {
                    managedObjectContext.delete(movie as! NSManagedObject)
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedObjectContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func saveToStorage(type:MovieType){
        // Save to local storage
        let managedObjectContext = SingleTon.shared.cdContext
        do {
            try managedObjectContext!.save()
        } catch let e {
            print(e)
        }
    }
    
    
    // Get data from local storage
    func fetchFromStorage(type:MovieType) -> [Movie] {
        let managedObjectContext = SingleTon.shared.cdContext
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate.init(format: "type=%@", type.rawValue)
        var sortDescriptor:NSSortDescriptor!
        if type == .popular{
            sortDescriptor = NSSortDescriptor(key: "popularity", ascending: false)
        }else if type == .topRated{
            sortDescriptor = NSSortDescriptor(key: "vote_average", ascending: false)
        }else{
            sortDescriptor = NSSortDescriptor(key: "release_date", ascending: false)
        }
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let movies = try managedObjectContext!.fetch(fetchRequest)
            return movies
        } catch let error {
            print(error)
            return []
        }
    }
}
