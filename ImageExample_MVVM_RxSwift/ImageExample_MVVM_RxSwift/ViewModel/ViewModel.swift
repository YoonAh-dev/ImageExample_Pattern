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

    struct Input {
        let directionArrowDidTap: PublishRelay<Direction>
        let submitDidTap: Observable<Void>
        let didScroll: PublishRelay<(width: Double, offset: Double)>
    }

    struct Output {
        let countRelay: BehaviorRelay<Int> = BehaviorRelay(value: 1)
        let imageUrlRelay: BehaviorRelay<[String]> = BehaviorRelay(value: [])
        let currentPageRelay: PublishRelay<Int> = PublishRelay()
    }

    // MARK: - property

    private let output = Output()
    private let disposeBag = DisposeBag()

    private let service: UnsplashService

    // MARK: - init

    init(service: UnsplashService) {
        self.service = service
    }

    // MARK: - func

    func transform(input: Input) -> Output {
        input.directionArrowDidTap
            .withUnretained(self)
            .bind { owner, direction in
                let currentValue = owner.output.countRelay.value
                let count = owner.count(with: direction, currentValue: currentValue)
                owner.output.countRelay.accept(count)
            }
            .disposed(by: self.disposeBag)

        input.submitDidTap
            .withUnretained(self)
            .bind { owner, _ in
                let currentValue = owner.output.countRelay.value
                owner.fetchImage(currentPage: currentValue)
            }
            .disposed(by: self.disposeBag)

        input.didScroll
            .withUnretained(self)
            .bind { owner, value in
                let currentPage = owner.currentPage(with: value.width, value.offset)
                owner.output.currentPageRelay.accept(currentPage)
            }
            .disposed(by: self.disposeBag)

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
            self.output.imageUrlRelay.accept(urls)
        }
    }

    private func currentPage(with width: Double, _ offset: Double) -> Int {
        return Int(offset / width)
    }
}
