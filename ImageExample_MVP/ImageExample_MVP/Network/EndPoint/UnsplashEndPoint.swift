//
//  UnsplashEndPoint.swift
//  ImageExample_MVP
//
//  Created by SHIN YOON AH on 2023/04/11.
//

import Foundation

enum UnsplashEndPoint {
    case fetchRandomImages(count: Int)

    var requestTimeOut: Float {
        return 20
    }

    var httpMethod: String {
        switch self {
        case .fetchRandomImages:
            return "GET"
        }
    }

    var requestBody: Data? {
        switch self {
        case .fetchRandomImages:
            return nil
        }
    }

    func getURL(baseURL: String) -> String {
        switch self {
        case .fetchRandomImages(let count):
            return "\(baseURL)/photos/random?count=\(count)"
        }
    }

    func createRequest() -> NetworkRequest {
        return NetworkRequest(url: getURL(baseURL: APIEnvironment.url),
                              reqBody: requestBody,
                              reqTimeout: requestTimeOut,
                              httpMethod: httpMethod
        )
    }
}
