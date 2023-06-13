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

    let countRelay: BehaviorRelay<Int> = BehaviorRelay(value: 0)

    // MARK: - func
    
    func handleCount(with direction: Direction) {
        let count = self.calculateCount(with: direction)
        self.countRelay.accept(count)
    }

    func fetchImage() {
        
    }

    // MARK: - Private - func

    private func calculateCount(with direction: Direction) -> Int {
        var currentValue = self.countRelay.value

        switch direction {
        case .left:
            guard currentValue > 0 else { return 0 }
            currentValue -= 1
        case .right:
            currentValue += 1
        }

        return currentValue
    }
}
