//
//  ResultState.swift
//  VeoTrendingMoviesApp
//
//  Created by Oliver Lauridsen on 29/09/2022.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [Result])
    case failed(error: Error)
}
