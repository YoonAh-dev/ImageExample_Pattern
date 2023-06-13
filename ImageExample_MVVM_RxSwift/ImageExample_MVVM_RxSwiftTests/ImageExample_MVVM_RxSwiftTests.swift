//
//  ImageExample_MVVM_RxSwiftTests.swift
//  ImageExample_MVVM_RxSwiftTests
//
//  Created by SHIN YOON AH on 2023/06/07.
//

import XCTest

@testable import ImageExample_MVVM_RxSwift

final class ImageExample_MVVM_RxSwiftTests: XCTestCase {

    private var service: UnsplashService?

    override func setUpWithError() throws {
        self.service = UnsplashService()
    }

    override func tearDownWithError() throws {
        self.service = nil
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func test_fetch_image() {
        Task {
            let count = 3
            let urls = await self.service?.imageURLs(count: count)
            DispatchQueue.main.async {
                XCTAssertEqual(urls?.count, count)
            }
        }
    }
}
