//
//  NetworkRequest.swift
//  ImageExample_MVP
//
//  Created by SHIN YOON AH on 2023/04/11.
//

import Foundation

struct NetworkRequest {
    let url: String
    let headers: [String: String]?
    let body: Data?
    let requestTimeOut: Float?
    let httpMethod: String

    init(url: String,
        headers: [String: String]? = nil,
        reqBody: Data? = nil,
        reqTimeout: Float? = nil,
        httpMethod: String
    ) {
        self.url = url
        self.headers = headers
        self.body = reqBody
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }

    func buildURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Client-ID KVtPVt64UrQx60c_6Ne2odkNi1hYv7UPnVh5DbhtjG4", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = body
        return urlRequest
    }
}
