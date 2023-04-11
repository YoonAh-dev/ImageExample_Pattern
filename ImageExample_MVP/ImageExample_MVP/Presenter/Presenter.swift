//
//  Presenter.swift
//  ImageExample_MVP
//
//  Created by SHIN YOON AH on 2023/04/11.
//

import Foundation

final class Presenter {

    // MARK: - property

    private let unsplashService: UnsplashService
    private weak var viewDelegate: ViewControllerDelegate?

    private var count: Int = 0

    // MARK: - init

    init(unsplashService: UnsplashService) {
        self.unsplashService = unsplashService
    }

    // MARK: - func

    func configureDelegation(_ delegate: ViewControllerDelegate?) {
        self.viewDelegate = delegate
    }

    func decreaseCount() {
        guard count > 1 else { return }
        self.count -= 1
        self.viewDelegate?.displayCount(self.count)
    }

    func increaseCount() {
        self.count += 1
        self.viewDelegate?.displayCount(self.count)
    }

    func fetchImageURLs() async {
        let imageURLs = await self.unsplashService.imageURLs(count: self.count)
        self.viewDelegate?.displayImages(imageURLs: imageURLs)
    }
}
