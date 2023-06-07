//
//  NetworkError.swift
//  ImageExample_MVVM_RxSwift
//
//  Created by SHIN YOON AH on 2023/06/07.
//

import Foundation

enum NetworkError: Error {
    case encodingError
    case clientError(message: String?)
    case serverError
    case unknownError
}
