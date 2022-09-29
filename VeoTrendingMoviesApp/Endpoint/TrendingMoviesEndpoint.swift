//
//  TrendingMoviesEndpoint.swift
//  VeoTrendingMoviesApp
//
//  Created by Oliver Lauridsen on 29/09/2022.
//

import Foundation

// Uses protocol in order to make it reusable, in case we would need to add another API endpoint.
// Essentially, all this does is promote reusability down the line
protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseURL: URLComponents { get }

}

enum TrendingMoviesAPI {
    case getTrendingMovies
}

extension TrendingMoviesAPI: APIBuilder {
    
    var baseURL: URLComponents {
        switch self {
        case .getTrendingMovies:
            var url = URLComponents(string: "https://api.themoviedb.org/3/trending/movie/day")
            url?.queryItems = [
                URLQueryItem(name: "api_key", value: "631eb7f22ebdc2186334977ff25238ce")
            ]

            return url!
        }
    }

    
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseURL.url!)
    }
}

