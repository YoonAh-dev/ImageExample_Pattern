//
//  ViewController_Mock.swift
//  ImageExample_MVPTests
//
//  Created by SHIN YOON AH on 2023/04/11.
//

@testable import ImageExample_MVP

final class ViewController_Mock: ViewControllerDelegate {

    // MARK: - property

    var count: Int?
    var urls: [String]?
    var currentPage: Int?

    // MARK: - func

    func displayCount(_ count: Int) {
        self.count = count
    }

    func displayImages(imageURLs: [String]) {
        self.urls = imageURLs
    }

    func changePageControl(currentPage: Int) {
        self.currentPage = currentPage
    }
}
