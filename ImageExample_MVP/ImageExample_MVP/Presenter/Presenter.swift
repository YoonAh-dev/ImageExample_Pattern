//
//  Presenter.swift
//  ImageExample_MVP
//
//  Created by SHIN YOON AH on 2023/04/11.
//

import Foundation

final class Presenter {

    // MARK: - property

    private weak var viewDelegate: ViewControllerDelegate?

    private var count: Int = 0

    // MARK: - func

    func configureDelegation(_ delegate: ViewControllerDelegate?) {
        self.viewDelegate = delegate
    }

    func decreaseCount() {
        guard count > 0 else { return }
        self.count -= 1
        self.viewDelegate?.displayCount(self.count)
    }

    func increaseCount() {
        self.count += 1
        self.viewDelegate?.displayCount(self.count)
    }
}
