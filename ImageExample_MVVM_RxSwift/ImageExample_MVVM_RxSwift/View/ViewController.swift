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

    private let disposeBag = DisposeBag()
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
    }

    private func bindInput() {
        self.leftButton.rx.controlEvent(.touchUpInside)
            .withUnretained(self)
            .bind { owner, _ in owner.viewModel.handleCount(with: .left) }
            .disposed(by: self.disposeBag)

        self.rightButton.rx.controlEvent(.touchUpInside)
            .withUnretained(self)
            .bind { owner, _ in owner.viewModel.handleCount(with: .right) }
            .disposed(by: self.disposeBag)

        self.submitButton.rx.controlEvent(.touchUpInside)
            .withUnretained(self)
            .bind { owner, _ in owner.viewModel.fetchImage() }
            .disposed(by: self.disposeBag)

        self.photoCollectionView.rx.didScroll
            .withUnretained(self)
            .bind { owner, _ in
                let width = owner.photoCollectionView.frame.width
                let offset = owner.photoCollectionView.contentOffset.x
                owner.viewModel.handleCurrentPage(with: width, offset)
            }
            .disposed(by: self.disposeBag)
    }

    private func bindOutput() {
        self.viewModel.countRelay
            .map { "\($0)" }
            .bind(to: self.photoCountLabel.rx.text)
            .disposed(by: self.disposeBag)

        self.viewModel.currentPageRelay
            .observe(on: MainScheduler.instance)
            .bind(to: self.pageControl.rx.currentPage)
            .disposed(by: self.disposeBag)

        let imageUrlRelay = self.viewModel.imageUrlRelay
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
