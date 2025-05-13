//
//  Movie.swift
//  GlobeAppExam
//
//  Created by CRAMJ on 5/14/25.
//

import Foundation

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String?
    let videoURL: URL?
    let artworkURL: URL?
    let genre: String?
    let advisoryRate: String?

    var localArtworkPath: String? = nil
    var localVideoPath: String? = nil

    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case title = "trackName"
        case description = "longDescription"
        case videoURL = "previewUrl"
        case artworkURL = "artworkUrl100"
        case genre = "primaryGenreName"
        case advisoryRate = "contentAdvisoryRating"
    }

    init(id: Int, title: String, description: String?, videoURL: URL?, artworkURL: URL?, localArtworkPath: String? = nil, localVideoPath: String? = nil, genre: String? = nil, advisoryRate: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.videoURL = videoURL
        self.artworkURL = artworkURL
        self.localArtworkPath = localArtworkPath
        self.localVideoPath = localVideoPath
        self.genre = genre
        self.advisoryRate = advisoryRate
    }
}
