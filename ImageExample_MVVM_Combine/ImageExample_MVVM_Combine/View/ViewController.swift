//
//  ViewController.swift
//  ImageExample_MVVM_RxSwift
//
//  Created by SHIN YOON AH on 2023/06/07.
//

import Combine
import UIKit

final class ViewController: UIViewController {

    // MARK: - ui component

    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var photoCountLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!

    private let flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width,
                                     height: UIScreen.main.bounds.size.width * 0.53)
        flowLayout.minimumInteritemSpacing = .zero
        flowLayout.minimumLineSpacing = .zero
        flowLayout.sectionInset = .zero
        return flowLayout
    }()
    private var dataSource: PhotoCollectionViewDataSource<PhotoCollectionViewCell, String>!

    // MARK: - property

    private var cancelBag = Set<AnyCancellable>()
    private let viewModel: ViewModel = ViewModel(service: UnsplashService())

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindInput()
        self.bindOutput()
    }

    // MARK: - func

    private func configureUI() {
        self.photoCollectionView.collectionViewLayout = self.flowLayout
        self.photoCollectionView.dataSource = self.photoCollectionViewDataSource(items: [])
    }

    private func bindInput() {
        self.leftButton.tapPublisher
            .sink(receiveValue: { [weak self] _ in
                self?.viewModel.handleCount(with: .left)
            })
            .store(in: &cancelBag)

        self.rightButton.tapPublisher
            .sink(receiveValue: { [weak self] _ in
                self?.viewModel.handleCount(with: .right)
            })
            .store(in: &cancelBag)

        self.submitButton.tapPublisher
            .sink(receiveValue: { [weak self] _ in
                self?.viewModel.fetchImage()
            })
            .store(in: &cancelBag)

        self.photoCollectionView.scrollPublisher
            .sink(receiveValue: { [weak self] _ in
                if let width = self?.photoCollectionView.frame.width,
                   let offset = self?.photoCollectionView.contentOffset.x {
                    self?.viewModel.handleCurrentPage(with: width, offset)
                }
            })
            .store(in: &cancelBag)
    }

    private func bindOutput() {
        self.viewModel.$count
            .map { "\($0)" }
            .assign(to: \.text, on: self.photoCountLabel)
            .store(in: &cancelBag)

        self.viewModel.currentPageSubject
            .receive(on: RunLoop.main)
            .assign(to: \.currentPage, on: self.pageControl)
            .store(in: &cancelBag)

        let imageUrlPublisher = self.viewModel.$imageUrl
            .share()

        imageUrlPublisher
            .map { self.photoCollectionViewDataSource(items: $0) }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] dataSource in
                guard let self = self else { return }
                self.dataSource = dataSource
                self.photoCollectionView.dataSource = self.dataSource
                self.photoCollectionView.reloadData()
            })
            .store(in: &cancelBag)

        imageUrlPublisher
            .map { $0.count }
            .receive(on: RunLoop.main)
            .assign(to: \.numberOfPages, on: self.pageControl)
            .store(in: &cancelBag)
    }

    private func photoCollectionViewDataSource<T>(items: [T]) -> PhotoCollectionViewDataSource<PhotoCollectionViewCell, T> {
        return PhotoCollectionViewDataSource(identifier: PhotoCollectionViewCell.identifier,
                                             items: items) { cell, item in
            if let item = item as? String {
                cell.configureCell(imageURL: item)
            }
        }
    }
}
