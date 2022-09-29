//
//  APIError.swift
//  VeoTrendingMoviesApp
//
//  Created by Oliver Lauridsen on 29/09/2022.
//

import Foundation

enum APIError: Error {
    case DecodingError
    case errorCode(Int)
    case unknown
}

// TODO: Research LocalizedError protocol
extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .DecodingError:
            return "Failed to decode the object from the service"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .unknown:
            return "The error is unknown"
        }
    }
}
