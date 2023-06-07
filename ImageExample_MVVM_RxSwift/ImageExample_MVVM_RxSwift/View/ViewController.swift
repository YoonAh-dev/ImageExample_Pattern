//
//  ViewController.swift
//  ImageExample_MVVM_RxSwift
//
//  Created by SHIN YOON AH on 2023/06/07.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - ui component

    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var photoCountLabel: UILabel!

    // MARK: - property

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
        self.photoCollectionView.delegate = self
        self.photoCollectionView.dataSource = self
    }

    // MARK: - IBAction

    @IBAction func didTapLeftButton(_ sender: Any) {

    }

    @IBAction func didTapRightButton(_ sender: Any) {

    }

    @IBAction func didTapSubmitButton(_ sender: Any) {

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
