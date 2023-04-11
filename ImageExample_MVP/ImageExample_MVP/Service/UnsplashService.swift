//
//  UnsplashService.swift
//  ImageExample_MVP
//
//  Created by SHIN YOON AH on 2023/04/11.
//

import Foundation

enum UnsplashImageError: Error {
    case invalid
}

struct UnsplashService {

    // MARK: - property

    private let unsplashAPI: UnsplashAPI = UnsplashAPI()

    // MARK: - func

    func imageURLs(count: Int) async -> [String] {
        do {
            let images = try await self.unsplashAPI.fetchRandomImages(count: count)
            let imageURLs = images?.compactMap { $0.urls?.regular }
            return imageURLs ?? []
        } catch {
            return []
        }
    }
}
