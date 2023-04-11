//
//  NetworkError.swift
//  ImageExample_MVP
//
//  Created by SHIN YOON AH on 2023/04/11.
//

import Foundation

enum NetworkError: Error {
    case encodingError
    case clientError(message: String?)
    case serverError
    case unknownError
}
