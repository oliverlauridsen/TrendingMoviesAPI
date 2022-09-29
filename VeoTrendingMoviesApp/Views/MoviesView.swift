//
//  MoviesView.swift
//  VeoTrendingMoviesApp
//
//  Created by Oliver Lauridsen on 29/09/2022.
//

import SwiftUI
import URLImage

struct MoviesView: View {
    
    let movie: Result

    var body: some View {
        let posterPathInString = String(movie.posterPath!)
        
            HStack {
                if let imgURL = "https://image.tmdb.org/t/p/w500\(posterPathInString)",
                   let url = URL(string: imgURL) {

                    URLImage(url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .frame(width: 150, height: 200)
                    .cornerRadius(10)

                } else {
                    Image(systemName: "photo.fill")
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .frame(width: 100, height: 100)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.title ?? "")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .semibold))
                    Text(movie.overview ?? "")
                        .foregroundColor(.gray)
                        .font(.system(size: 12, weight: .regular))
                }
            }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(movie: Result.dummyData)
            .previewLayout(.sizeThatFits)
    }
}

