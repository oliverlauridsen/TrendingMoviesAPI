//
//  HomeView.swift
//  VeoTrendingMoviesApp
//
//  Created by Oliver Lauridsen on 29/09/2022.
//


import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = TrendingMoviesViewModelImplementation(service: TrendingMoviesServiceImplementation())
    
    var body: some View {
        
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .success(let movies):
                    NavigationView {
                        List(movies) { item in
                            NavigationLink(destination: MovieDetailView(movie:item)) {
                                MoviesView(movie: item)
                            }
                        }
                        .navigationTitle(Text("Trending Movies"))
                    }
                
            case .failed(error: let error):
                ErrorView(error: error, handler: viewModel.getMovies)
            }
        }.onAppear(perform: viewModel.getMovies)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
