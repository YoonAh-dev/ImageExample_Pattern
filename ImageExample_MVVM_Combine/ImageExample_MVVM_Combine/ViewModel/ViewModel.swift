//
//  ViewModel.swift
//  ImageExample_MVVM_RxSwift
//
//  Created by SHIN YOON AH on 2023/06/07.
//

import Combine
import Foundation

final class ViewModel {

    enum Direction {
        case left, right
    }

    // MARK: - property

    private let service: UnsplashService

    @Published var count: Int = 1
    @Published var imageUrl: [String] = []

    let currentPageSubject: PassthroughSubject<Int, Never> = PassthroughSubject()

    // MARK: - init

    init(service: UnsplashService) {
        self.service = service
    }

    // MARK: - func

    func handleCount(with direction: Direction) {
        self.count = self.calculateCount(with: direction)
    }

    func fetchImage() {
        Task {
            let count = self.count
            let urls = await self.service.imageURLs(count: count)
            self.imageUrl = urls
        }
    }

    func handleCurrentPage(with width: Double, _ offset: Double) {
        let currentPage = Int(offset / width)
        self.currentPageSubject.send(currentPage)
    }

    // MARK: - Private - func

    private func calculateCount(with direction: Direction) -> Int {
        var currentValue = self.count

        switch direction {
        case .left:
            guard currentValue > 1 else { return 1 }
            currentValue -= 1
        case .right:
            currentValue += 1
        }

        return currentValue
    }
}
