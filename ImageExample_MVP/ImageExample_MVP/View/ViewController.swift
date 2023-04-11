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
    func changePageControl(currentPage: Int)
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
        self.photoCollectionView.delegate = self
        self.photoCollectionView.dataSource = self
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
        DispatchQueue.main.async {
            self.imageURLs = imageURLs
            self.pageControl.numberOfPages = imageURLs.count
        }
    }

    func changePageControl(currentPage: Int) {
        self.pageControl.currentPage = currentPage
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageURLs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(imageURL: self.imageURLs[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let offset = scrollView.contentOffset.x
        self.presenter.changeCurrentPage(with: Double(width), Double(offset))
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width * 0.53)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
