//
//  UnsplashAPI.swift
//  ImageExample_MVP
//
//  Created by SHIN YOON AH on 2023/04/11.
//

import Foundation

protocol UnsplashProtocol {
    func fetchRandomImages(count: Int) async throws -> [Image]?
}

struct UnsplashAPI: UnsplashProtocol {
    func fetchRandomImages(count: Int) async throws -> [Image]? {
        let request = UnsplashEndPoint
            .fetchRandomImages(count: count)
            .createRequest()
        return try await APIRequest().request(request)
    }
}
