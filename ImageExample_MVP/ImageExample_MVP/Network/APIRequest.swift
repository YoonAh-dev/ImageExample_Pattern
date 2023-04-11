//
//  APIRequest.swift
//  ImageExample_MVP
//
//  Created by SHIN YOON AH on 2023/04/11.
//

import Foundation

final class APIRequest {

    var requestTimeOut: Float = 30

    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T? {
        let (data, httpResponse) = try await requestDataToUrl(request)

        switch httpResponse.statusCode {
        case (200..<300):
            let decoder = JSONDecoder()
            let baseModelData: T? = try decoder.decode(T.self, from: data)
            return baseModelData
        case (300..<500):
            throw NetworkError.clientError(message: httpResponse.statusCode.description)
        default:
            throw NetworkError.serverError
        }
    }
}

extension APIRequest {
    typealias UrlResponse = (Data, HTTPURLResponse)

    private func requestDataToUrl(_ request: NetworkRequest) async throws -> UrlResponse {
        let sessionConfig = URLSessionConfiguration.default
        guard let encodedUrl = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedUrl) else {
            throw NetworkError.encodingError
        }
        print("encodedUrl = \(encodedUrl)")

        let (data, response) = try await URLSession.shared.data(for: request.buildURLRequest(with: url))
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.serverError }

        return (data, httpResponse)
    }
}
