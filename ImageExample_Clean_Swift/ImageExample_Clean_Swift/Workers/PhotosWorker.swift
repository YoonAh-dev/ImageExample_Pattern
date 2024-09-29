//
//  PhotosWorker.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 9/29/24.
//

import Foundation

protocol PhotosWorker {
    func fetchRandomPhotoURLs(count: Int) async -> [String]
}

final actor PhotosWorkerImpl: PhotosWorker {
    
    let unsplashAPI: UnsplashProtocol
    
    init(unsplashAPI: UnsplashProtocol) {
        self.unsplashAPI = unsplashAPI
    }
    
    func fetchRandomPhotoURLs(count: Int) async -> [String] {
        do {
            let images = try await unsplashAPI.fetchRandomImages(count: count)
            let imageURLs = images?.compactMap { $0.urls?.regular }
            return imageURLs ?? []
        } catch {
            return []
        }
    }
}
