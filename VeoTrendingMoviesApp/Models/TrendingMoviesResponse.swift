//
//  TrendingMoviesResponse.swift
//  VeoTrendingMoviesApp
//
//  Created by Oliver Lauridsen on 29/09/2022.
//


import Foundation

// MARK: - TrendingMoviesResponse
struct TrendingMoviesResponse: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
struct Result: Codable, Identifiable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let title: String?
    let originalTitle, overview, posterPath: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
    }
}



extension Result {
    static var dummyData: Result {
        .init(adult: false,
              backdropPath: "https://image.tmdb.org/t/p/w500/pdD47rPAYKVdPasoyhSAFPIFIWo.jpg",
              id: 718930,
              title: "Bullet Train",
              originalTitle: "Bullet Train",
              overview: "Unlucky assassin Ladybug is determined to do his job peacefully after one too many gigs gone off the rails. Fate, however, may have other plans, as Ladybug's latest mission puts him on a collision course with lethal adversaries from around the globe—all with connected, yet conflicting, objectives—on the world's fastest train.",
              posterPath: "https://image.tmdb.org/t/p/w500/tVxDe01Zy3kZqaZRNiXFGDICdZk.jpg")
    }
}
