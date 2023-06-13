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

    struct Input {
        let directionArrowDidTap: PassthroughSubject<Direction, Never>
        let submitDidTap: AnyPublisher<Void, Never>
        let didScroll: PassthroughSubject<(width: Double, offset: Double), Never>
    }

    struct Output {
        let countSubject: CurrentValueSubject<Int, Never> = CurrentValueSubject(1)
        let imageUrlSubject: CurrentValueSubject<[String], Never> = CurrentValueSubject([])
        let currentPageSubject: PassthroughSubject<Int, Never> = PassthroughSubject()
    }

    // MARK: - property

    private let output = Output()
    private var cancelBag = Set<AnyCancellable>()

    private let service: UnsplashService

    // MARK: - init

    init(service: UnsplashService) {
        self.service = service
    }

    // MARK: - func

    func transform(input: Input) -> Output {
        input.directionArrowDidTap
            .sink(receiveValue: { [weak self] direction in
                guard let self = self else { return }
                let currentValue = self.output.countSubject.value
                let count = self.count(with: direction, currentValue: currentValue)
                self.output.countSubject.send(count)
            })
            .store(in: &cancelBag)

        input.submitDidTap
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                let page = self.output.countSubject.value
                self.fetchImage(currentPage: page)
            })
            .store(in: &cancelBag)

        input.didScroll
            .map { self.currentPage(with: $0.width, $0.offset) }
            .sink(receiveValue: { [weak self] page in
                self?.output.currentPageSubject.send(page)
            })
            .store(in: &cancelBag)

        return self.output
    }

    // MARK: - Private - func

    private func count(with direction: Direction, currentValue: Int) -> Int {
        return self.calculateCount(with: direction, currentValue: currentValue)
    }

    private func calculateCount(with direction: Direction, currentValue: Int) -> Int {
        var currentValue = currentValue

        switch direction {
        case .left:
            guard currentValue > 1 else { return 1 }
            currentValue -= 1
        case .right:
            currentValue += 1
        }

        return currentValue
    }

    private func fetchImage(currentPage: Int) {
        Task {
            let urls = await self.service.imageURLs(count: currentPage)
            self.output.imageUrlSubject.send(urls)
        }
    }

    private func currentPage(with width: Double, _ offset: Double) -> Int {
        return Int(offset / width)
    }
}
