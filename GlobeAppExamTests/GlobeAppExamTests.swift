//
//  MovieAppTests.swift
//  GlobeAppExam
//
//  Created by CRAMJ on 5/14/25.
//


import XCTest
@testable import GlobeAppExam

final class GlobeAppExamTests: XCTestCase {

    func testMovieDecoding() throws {
        let json = """
        {
            "trackId": 12345,
            "trackName": "Venom Movie",
            "longDescription": "A test movie description.",
            "previewUrl": "https://example.com/video.mp4",
            "artworkUrl100": "https://example.com/image.jpg"
        }
        """.data(using: .utf8)!

        let movie = try JSONDecoder().decode(Movie.self, from: json)
        XCTAssertEqual(movie.id, 12345)
        XCTAssertEqual(movie.title, "Venom Movie")
        XCTAssertEqual(movie.description, "A test movie description.")
        XCTAssertEqual(movie.videoURL?.absoluteString, "https://example.com/video.mp4")
        XCTAssertEqual(movie.artworkURL?.absoluteString, "https://example.com/image.jpg")
    }

    func testNetworkServiceReturnsMovies() async throws {
        let service = NetworkService()
        let movies = try await service.fetchMovies()
        XCTAssertFalse(movies.isEmpty, "Movies list should not be empty")
    }

    func testLocalStorageSaveAndLoad() {
        let localStorage = LocalStorage()
        let movie = Movie(id: 1, title: "Test Movie", description: "Test", videoURL: nil, artworkURL: nil)

        localStorage.save([movie])
        let loadedMovies = localStorage.load()

        XCTAssertNotNil(loadedMovies)
        XCTAssertEqual(loadedMovies?.count, 1)
        XCTAssertEqual(loadedMovies?.first?.title, "Test Movie")
    }

    func testMovieListViewModelLoading() async {
        let viewModel = await MovieListViewModel()
        await viewModel.loadMovies()
        
        await MainActor.run {
            XCTAssertFalse(viewModel.movies.isEmpty, "ViewModel should load movies")
        }
    }

    func testMovieViewModelSearchFilter() async {
        let viewModel = await MovieListViewModel()
        await viewModel.loadMovies()
        
        await MainActor.run {
            viewModel.searchText = "venom"
        }

        let filtered = await MainActor.run {
            viewModel.filteredMovies
        }

        XCTAssertTrue(filtered.allSatisfy { $0.title.lowercased().contains("venom") }, "All filtered movies should contain 'venom'")
    }

}
