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

    private var imageURLs: [String] = [] {
        didSet { self.photoCollectionView.reloadData() }
    }

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBAction

    @IBAction func didTapLeftButton(_ sender: Any) {

    }

    @IBAction func didTapRightButton(_ sender: Any) {

    }

    @IBAction func didTapSubmitButton(_ sender: Any) {

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
