//
//  TrendingMoviesService.swift
//  VeoTrendingMoviesApp
//
//  Created by Oliver Lauridsen on 29/09/2022.
//

import Foundation
import Combine

// Protocol used to promote dependency injection
// makes this protocol as testable as it can be

protocol TrendingMoviesService {
    
    // AnyPublisher allows up to subscribe and listen to the event we want to publish
    // Uses generics -> first param is success, second param is error if found
    func request(from endpoint: TrendingMoviesAPI) -> AnyPublisher<TrendingMoviesResponse, APIError>
    
}

struct TrendingMoviesServiceImplementation: TrendingMoviesService {
    func request(from endpoint: TrendingMoviesAPI) -> AnyPublisher<TrendingMoviesResponse, APIError> {

        // URLSession used to send API call
        return URLSession
            // access the singleton "shared" from URLSession
            .shared
            // What we get from combine framework, to listen to the result of the service TODO: Research a bit more
            .dataTaskPublisher(for: endpoint.urlRequest)
            // Receive on main thread, since the URLSession call defaults to the background asynchrounously
            .receive(on: DispatchQueue.main)
            // If something goes wrong, map the error to our enum
            .mapError{ _ in APIError.unknown }
            // Flatten everything we get back from API.
            .flatMap { data, response -> AnyPublisher<TrendingMoviesResponse, APIError> in
                
                // Attempt to cast response as HTTPURLResponse, throw fatal error if it fails
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                // If within range of status codes,
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    let decodedData = Just(data).decode(type: TrendingMoviesResponse.self, decoder: jsonDecoder).mapError{ _ in APIError.DecodingError }.eraseToAnyPublisher()
                    return decodedData
                } else {
                    // If we're not succeMediaTypesful, return a Failure object with the error being set as APIError.
                    // .eraseToAnyPublisher() to create a generic publisher
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
               
                
            }
            // Convert value into a generic publisher, that we can send back and listen to the value on
            .eraseToAnyPublisher()
    }
    
}
