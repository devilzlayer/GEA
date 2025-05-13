//
//  NetworkService.swift
//  GlobeAppExam
//
//  Created by CRAMJ on 5/14/25.
//

import Foundation

struct NetworkService {
    func fetchMovies() async throws -> [Movie] {
        let url = URL(string: Constants.baseURL)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let wrapper = try JSONDecoder().decode(MovieResponseWrapper.self, from: data)

        // Initialize movies but don't start downloading yet
        return wrapper.results.filter { $0.videoURL != nil }
    }

    // Start downloading only when media is needed
    func downloadMedia(from url: URL, filename: String) async -> String? {
        let localURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            try data.write(to: localURL)
            return localURL.path
        } catch {
            return nil
        }
    }
}

struct MovieResponseWrapper: Codable {
    let results: [Movie]
}
