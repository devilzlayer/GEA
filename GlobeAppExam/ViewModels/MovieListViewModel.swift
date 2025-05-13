//
//  MovieListViewModel.swift
//  GlobeAppExam
//
//  Created by CRAMJ on 5/14/25.
//

import Foundation

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchText: String = ""

    private let networkService = NetworkService()
    private let localStorage = LocalStorage()

    var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    // Load movies and display immediately
    func loadMovies() async {
        do {
            let fetchedMovies = try await networkService.fetchMovies()
            movies = fetchedMovies
            localStorage.save(fetchedMovies)
        } catch {
            if let cachedMovies = localStorage.load() {
                movies = cachedMovies
            }
        }
    }

    // Download video when it's needed (only when shown in detail view)
    func downloadVideo(for movie: Movie) async {
        guard movie.localVideoPath == nil, let videoURL = movie.videoURL else { return }

        if let downloadedPath = await networkService.downloadMedia(from: videoURL, filename: "preview-\(movie.id).mp4") {
            if let index = movies.firstIndex(where: { $0.id == movie.id }) {
                movies[index].localVideoPath = downloadedPath
            }
        }
    }
}

