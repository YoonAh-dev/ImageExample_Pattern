//
//  UnsplashAPI.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 9/29/24.
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
