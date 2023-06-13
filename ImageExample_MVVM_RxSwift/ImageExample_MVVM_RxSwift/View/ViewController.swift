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

    // MARK: - property

    private let disposeBag = DisposeBag()
    private let viewModel: ViewModel = ViewModel(service: UnsplashService())

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindInput()
        self.bindOutput()
    }

    // MARK: - func

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
    }

    private func bindOutput() {
        self.viewModel.countRelay
            .map { "\($0)" }
            .bind(to: self.photoCountLabel.rx.text)
            .disposed(by: self.disposeBag)

        self.viewModel.imageUrlRelay
            .observe(on: MainScheduler.instance)
            .bind(to: self.photoCollectionView.rx.items(cellIdentifier: PhotoCollectionViewCell.identifier,
                                                        cellType: PhotoCollectionViewCell.self)) { index, element, cell in
                cell.configureCell(imageURL: element)
            }
            .disposed(by: self.disposeBag)
    }
}

//// MARK: - UICollectionViewDelegate
//extension ViewController: UICollectionViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let width = scrollView.frame.width
//        let offset = scrollView.contentOffset.x
//    }
//}
//
//// MARK: - UICollectionViewDelegateFlowLayout
//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width * 0.53)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets.zero
//    }
//}
