//
//  LocalStorage.swift
//  GlobeAppExam
//
//  Created by CRAMJ on 5/14/25.
//

import Foundation

struct LocalStorage {
    private let fileName = Constants.localFileName

    private var fileURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
    }

    func save(_ items: [Movie]) {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL)
    }

    func load() -> [Movie]? {
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return try? JSONDecoder().decode([Movie].self, from: data)
    }
}
