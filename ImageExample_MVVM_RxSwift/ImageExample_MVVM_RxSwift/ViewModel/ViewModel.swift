//
//  ViewModel.swift
//  ImageExample_MVVM_RxSwift
//
//  Created by SHIN YOON AH on 2023/06/07.
//

import Foundation

import RxCocoa
import RxSwift

final class ViewModel {

    enum Direction {
        case left, right
    }

    // MARK: - property

    private let service: UnsplashService

    let countRelay: BehaviorRelay<Int> = BehaviorRelay(value: 1)
    let imageUrlRelay: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    let currentPageRelay: PublishRelay<Int> = PublishRelay()

    // MARK: - init

    init(service: UnsplashService) {
        self.service = service
    }

    // MARK: - func
    
    func handleCount(with direction: Direction) {
        let count = self.calculateCount(with: direction)
        self.countRelay.accept(count)
    }

    func fetchImage() {
        Task {
            let count = self.countRelay.value
            let urls = await self.service.imageURLs(count: count)
            self.imageUrlRelay.accept(urls)
        }
    }

    func handleCurrentPage(with width: Double, _ offset: Double) {
        let currentPage = Int(offset / width)
        self.currentPageRelay.accept(currentPage)
    }

    // MARK: - Private - func

    private func calculateCount(with direction: Direction) -> Int {
        var currentValue = self.countRelay.value

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
