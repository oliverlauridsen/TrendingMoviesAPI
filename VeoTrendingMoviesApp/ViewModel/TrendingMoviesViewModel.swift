//
//  TrendingMoviesViewModel.swift
//  VeoTrendingMoviesApp
//
//  Created by Oliver Lauridsen on 29/09/2022.
//

import Foundation
import Combine

// Separate concerns using protocols, by making our classes less coupled
protocol TrendingMoviesViewModel {
    func getMovies()
}

// Class used because we want it to be an observable object.
// Want to observe the changes that happens to data inside this class.
class TrendingMoviesViewModelImplementation: ObservableObject, TrendingMoviesViewModel {
    
    private let service: TrendingMoviesService
    
    // Private(set) means protecting it within the class, but we can still access it outside the class
    private(set) var movies = [Result]()
    
    // We need a collection of cancelables because, when we call the service,
    // we need to keep it in memory, otherwise, it just gets disposed once the service is called.
    // So we need a collection that holds our requests
    private var cancellables = Set<AnyCancellable>()
    
    // default value of loading
    // we add @Published, to listen to whenever the state changes so we can react by updating the UI
    @Published private(set) var state: ResultState = .loading
    
    // We inject our TrendingMoviesService into the class
    // now we can use the service to start off the request to get our movies
    init(service: TrendingMoviesService) {
        self.service = service
    }
     
    func getMovies() {
        
        // make sure it's always set as loading initially
        self.state = .loading
        
        let cancellable = service
            .request(from: .getTrendingMovies)
            // .sink allows us to listen to the completion, if it was succesful or a failure, and when it's finished publishing
            .sink { res in
                switch res {
                    
                case .finished:
                    self.state = .success(content: self.movies)
                    
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                // When we get the value from the request, we want to store it in the movies array.
                self.movies = response.results
            }
        
        // We need to hold this in memory, so we need to insert the cancellable like so:
        self.cancellables.insert(cancellable)

    }
    
}
