//
//  MovieDetailView.swift
//  GlobeAppExam
//
//  Created by CRAMJ on 5/14/25.
//

import SwiftUI
import AVKit

struct MovieDetailView: View {
    let movie: Movie
    @StateObject private var viewModel = MovieListViewModel()
    @State private var player: AVPlayer?

    var body: some View {
        Text(movie.title)
            .font(.headline)
        VStack(alignment: .leading, spacing: 16) {
            if let path = movie.localVideoPath {
                VideoPlayer(player: AVPlayer(url: URL(fileURLWithPath: path)))
                    .frame(height: 250)
            } else if let url = movie.videoURL {
                VideoPlayer(player: player)
                    .frame(height: 250)
                    .onAppear {
                        // Start playing the video automatically
                        player = AVPlayer(url: url)
                        player?.play()
                        Task {
                            await viewModel.downloadVideo(for: movie)
                        }
                    }
                    .onDisappear {
                        // Stop playing and Release the player
                        player?.pause()
                        player = nil
                    }
            } else {
                Text(Constants.noPreview)
                    .foregroundColor(.gray)
            }
            if let description = movie.description {
                Text(description)
                    .font(.body)
                    .lineLimit(nil)
            } else {
                Text(Constants.noDescription)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
    }
}
