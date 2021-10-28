//
//  MovieDetail.swift
//  MovieBrowser
//
//  Created by manoj Singireddy on 10/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation


class MovieListViewModel {
    
    //MARK: Instance
    private var dataAccessManager: MovieAPI?
    var movieSuccess: (() -> ())?
    var movieError: ((NetworkError?) -> ())?
    
    var totalPages: Int?
    
    private var cellViewModels: [Movie] = [Movie]() {
        didSet {
            self.movieSuccess?()
        }
    }
    private var error: NetworkError? {
        didSet {
            self.movieError?(error)
        }
    }
    
    //MARK: Initializers
    
    required init( apiService: MovieAPI?) {
        self.dataAccessManager = apiService
    }
    
    //MARK: Helper Methds
    
    func getTotalMovies() -> Int {
        return cellViewModels.count
    }
    func resetMovies() {
        return cellViewModels.removeAll()
    }
    func getCellViewModel( at indexPath: IndexPath ) -> Movie {
        return cellViewModels[indexPath.row]
    }
    func initFetch(url: String) {
        dataAccessManager?.getMoviesList(url: url, completion: { [weak self] (movieContainer, error) in
         self?.processFetchedData(movieContainer: (movieContainer as? MovieContainer)!, error: error)
        })
        
    }
    private func processFetchedData( movieContainer: MovieContainer , error: NetworkError?) {
        guard error == nil else {
            self.error = error!
            return
        }
        let total = self.cellViewModels + movieContainer.results
        self.cellViewModels = total
    }
    
}


