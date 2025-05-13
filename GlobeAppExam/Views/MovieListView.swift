//
//  MovieListView.swift
//  GlobeAppExam
//
//  Created by CRAMJ on 5/14/25.
//

import SwiftUI
import Kingfisher

struct MovieListView: View {
    @StateObject var viewModel = MovieListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.filteredMovies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    HStack(alignment: .top, spacing: 12) {
                        KFImage(movie.artworkURL)
                            .resizable()
                            .roundCorner(radius: .point(10))
                            .frame(width: 100, height: 100)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(movie.title)
                                .font(.headline)
                            Text("Genre: \(movie.genre ?? "")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Rating: \(movie.advisoryRate ?? "")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle(Constants.title)
            .searchable(text: $viewModel.searchText, prompt: Constants.searchTitle)
        }
        .task {
            // Load movies on view load
            await viewModel.loadMovies()
        }
    }
}

#Preview {
    MovieListView()
}
