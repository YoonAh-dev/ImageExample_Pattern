//
//  ViewController.swift
//  ImageExample_MVP
//
//  Created by SHIN YOON AH on 2023/04/11.
//

import UIKit

protocol ViewControllerDelegate: AnyObject {
    func displayCount(_ count: Int)
    func displayImages(imageURLs: [String])
}

final class ViewController: UIViewController {

    // MARK: - ui component

    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var photoCountLabel: UILabel!

    // MARK: - property

    private let presenter: Presenter = Presenter(unsplashService: UnsplashService())
    private var imageURLs: [String] = [] {
        didSet { self.photoCollectionView.reloadData() }
    }

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDelegation()
    }

    // MARK: - func

    private func configureDelegation() {
        self.presenter.configureDelegation(self)
    }

    // MARK: - IBAction

    @IBAction func didTapLeftButton(_ sender: Any) {
        self.presenter.decreaseCount()
    }

    @IBAction func didTapRightButton(_ sender: Any) {
        self.presenter.increaseCount()
    }

    @IBAction func didTapSubmitButton(_ sender: Any) {
        Task {
            await self.presenter.fetchImageURLs()
        }
    }
}

// MARK: - ViewControllerDelegate
extension ViewController: ViewControllerDelegate {
    func displayCount(_ count: Int) {
        self.photoCountLabel.text = count.description
    }

    func displayImages(imageURLs: [String]) {
        self.imageURLs = imageURLs
        self.pageControl.numberOfPages = imageURLs.count
    }
}
