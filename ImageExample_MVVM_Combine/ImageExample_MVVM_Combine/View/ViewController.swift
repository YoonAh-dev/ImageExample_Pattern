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

    private let directionArrowDidTapSubject: PassthroughSubject<ViewModel.Direction, Never> = PassthroughSubject()
    private let didScrollSubject: PassthroughSubject<(width: Double, offset: Double), Never> = PassthroughSubject()

    private var cancelBag = Set<AnyCancellable>()
    private let viewModel: ViewModel = ViewModel(service: UnsplashService())

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bind()
    }

    // MARK: - func

    private func configureUI() {
        self.photoCollectionView.collectionViewLayout = self.flowLayout
        self.photoCollectionView.dataSource = self.photoCollectionViewDataSource(items: [])
    }

    private func bind() {
        let input = ViewModel.Input(
            directionArrowDidTap: self.directionArrowDidTapSubject,
            submitDidTap: self.submitButton.tapPublisher,
            didScroll: self.didScrollSubject
        )
        self.bindInput()
        self.bindOutput(from: input)
    }

    private func bindInput() {
        self.leftButton.tapPublisher
            .map { ViewModel.Direction.left }
            .sink(receiveValue: { [weak self] in
                self?.directionArrowDidTapSubject.send($0)
            })
            .store(in: &cancelBag)

        self.rightButton.tapPublisher
            .map { ViewModel.Direction.right }
            .sink(receiveValue: { [weak self] in
                self?.directionArrowDidTapSubject.send($0)
            })
            .store(in: &cancelBag)

        self.photoCollectionView.scrollPublisher
            .sink(receiveValue: { [weak self] _ in
                if let width = self?.photoCollectionView.frame.width,
                   let offset = self?.photoCollectionView.contentOffset.x {
                    self?.didScrollSubject.send((width, offset))
                }
            })
            .store(in: &cancelBag)
    }

    private func bindOutput(from input: ViewModel.Input) {
        let output = self.viewModel.transform(input: input)

        output.countSubject
            .map { "\($0)" }
            .assign(to: \.text, on: self.photoCountLabel)
            .store(in: &cancelBag)

        output.currentPageSubject
            .receive(on: RunLoop.main)
            .assign(to: \.currentPage, on: self.pageControl)
            .store(in: &cancelBag)

        let imageUrlPublisher = output.imageUrlSubject
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
