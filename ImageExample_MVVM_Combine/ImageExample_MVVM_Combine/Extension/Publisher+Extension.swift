//
//  Publisher+Extension.swift
//  ImageExample_MVVM_Combine
//
//  Created by SHIN YOON AH on 2023/06/13.
//

import Combine

extension Publisher {
    func mapToVoid() -> Publishers.Map<Self, Void> {
        return self.map { _ in Void() }
    }
}
