//
//  ImageExample_MVPTests.swift
//  ImageExample_MVPTests
//
//  Created by SHIN YOON AH on 2023/04/11.
//

import XCTest
@testable import ImageExample_MVP

final class ImageExample_MVPTests: XCTestCase {

    private var sut: Presenter?
    private var mockView: ViewController_Mock?

    override func setUpWithError() throws {
        self.mockView = ViewController_Mock()
        self.sut = Presenter(unsplashService: UnsplashService())
        self.sut?.configureDelegation(self.mockView)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.mockView = nil
    }

    func testExample() throws { }

    func testPerformanceExample() throws {
        self.measure { }
    }

    func test_increaseCount_countValue가_제대로_설정이_되는가() {
        self.sut?.increaseCount()
        XCTAssertEqual(2, self.mockView?.count)
    }

    func test_decreaseCount_count가_1일때_countValue가_제대로_설정이_되는가_fail() {
        self.sut?.decreaseCount()
        XCTAssertEqual(nil, self.mockView?.count)
    }

    func test_decreaseCount_count가_1일때_countValue가_제대로_설정이_되는가() {
        self.sut?.decreaseCount()
        XCTAssertEqual(1, self.mockView?.count)
    }

    func test_currentPage가_제대로_설정이_되는가() {
        let width: Double = 100
        let offset: Double = 400
        self.sut?.changeCurrentPage(with: width, offset)
        XCTAssertEqual(4, self.mockView?.currentPage)
    }
}
