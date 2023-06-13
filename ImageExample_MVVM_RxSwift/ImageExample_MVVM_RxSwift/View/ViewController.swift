//
//  ViewController.swift
//  ImageExample_MVVM_RxSwift
//
//  Created by SHIN YOON AH on 2023/06/07.
//

import UIKit

import RxCocoa
import RxSwift

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

    // MARK: - property

    private let directionArrowDidTapRelay: PublishRelay<ViewModel.Direction> = PublishRelay()
    private let didScrollRelay: PublishRelay<(width: Double, offset: Double)> = PublishRelay()

    private let disposeBag = DisposeBag()
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
    }

    private func bind() {
        let input = ViewModel.Input(
            directionArrowDidTap: self.directionArrowDidTapRelay,
            submitDidTap: self.submitButton.rx.controlEvent(.touchUpInside).asObservable(),
            didScroll: self.didScrollRelay
        )
        self.bindInput()
        self.bindOutput(from: input)
    }

    private func bindInput() {
        self.leftButton.rx.controlEvent(.touchUpInside)
            .map { ViewModel.Direction.left }
            .bind(to: self.directionArrowDidTapRelay)
            .disposed(by: self.disposeBag)

        self.rightButton.rx.controlEvent(.touchUpInside)
            .map { ViewModel.Direction.right }
            .bind(to: self.directionArrowDidTapRelay)
            .disposed(by: self.disposeBag)

        self.photoCollectionView.rx.didScroll
            .withUnretained(self)
            .bind { owner, _ in
                let width = owner.photoCollectionView.frame.width
                let offset = owner.photoCollectionView.contentOffset.x
                owner.didScrollRelay.accept((width, offset))
            }
            .disposed(by: self.disposeBag)
    }

    private func bindOutput(from input: ViewModel.Input) {
        let output = self.viewModel.transform(input: input)

        output.countRelay
            .map { "\($0)" }
            .bind(to: self.photoCountLabel.rx.text)
            .disposed(by: self.disposeBag)

        output.currentPageRelay
            .observe(on: MainScheduler.instance)
            .bind(to: self.pageControl.rx.currentPage)
            .disposed(by: self.disposeBag)

        let imageUrlRelay = output.imageUrlRelay
            .observe(on: MainScheduler.instance)
            .share()

        imageUrlRelay
            .bind(to: self.photoCollectionView.rx.items(cellIdentifier: PhotoCollectionViewCell.identifier,
                                                        cellType: PhotoCollectionViewCell.self)) { index, element, cell in
                cell.configureCell(imageURL: element)
            }
            .disposed(by: self.disposeBag)

        imageUrlRelay
            .map { $0.count }
            .bind(to: self.pageControl.rx.numberOfPages)
            .disposed(by: self.disposeBag)
    }
}
