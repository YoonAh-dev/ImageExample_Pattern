//
//  ImageCollectionView.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 9/29/24.
//

import Combine
import UIKit
import SnapKit

final class ImageCollectionView: UIView {
    
    private enum Section {
        case main
    }
    
    // MARK: - ui component
    
    private lazy var photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier
        )
        collectionView.delegate = self
        return collectionView
    }()
    private let pageControl: UIPageControl = UIPageControl()
    private let photoCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    private let leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()
    private let rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        return button
    }()
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("이미지 가져오기", for: .normal)
        return button
    }()
    
    // MARK: - property
    
    weak var delegate: ImageCollectionViewDelegate?
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    private var snapshot: NSDiffableDataSourceSnapshot<Section, String>!
    
    // MARK: - internal - property
    
    var leftButtonTapGesture: AnyPublisher<Void, Never> {
        return leftButton.tapPublisher
    }
    var rightButtonTapGesture: AnyPublisher<Void, Never> {
        return rightButton.tapPublisher
    }
    var submitButtonTapGesture: AnyPublisher<Void, Never> {
        return submitButton.tapPublisher
    }
    var pageControlValueDidChange = PassthroughSubject<(width: Double, offset: Double), Never>()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addSubViews()
        setupLayout()
        configureDataSource()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup
    
    private func configureUI() {
        backgroundColor = .systemGray
    }
    
    private func addSubViews() {
        addSubview(photoCollectionView)
        addSubview(pageControl)
        addSubview(photoCountLabel)
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(submitButton)
    }
    
    private func setupLayout() {
        photoCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.53)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(photoCollectionView.snp.bottom).offset(10)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }

        photoCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(submitButton.snp.top).offset(-100)
            $0.centerX.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints {
            $0.centerY.equalTo(photoCountLabel)
            $0.centerX.equalToSuperview().offset(-70)
        }
        
        rightButton.snp.makeConstraints {
            $0.centerY.equalTo(photoCountLabel)
            $0.centerX.equalToSuperview().offset(70)
        }
        
        submitButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(100)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - internal - func
    
    func setupCountLabel(count: String) {
        photoCountLabel.text = count
    }
    
    func setupPhotoCollectionView(photoURLs: [String]) {
        DispatchQueue.main.async { [weak self] in
            self?.reloadURLList(photoURLs)
            self?.updatePageControl()
        }
    }
    
    func setupCurrentPage(index: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.pageControl.currentPage = index
        }
    }
    
    // MARK: - helper - func
    
    private func updatePageControl() {
        pageControl.numberOfPages = photoCollectionView.numberOfItems(inSection: .zero)
        pageControl.currentPage = photoCollectionView.indexPathsForVisibleItems.first?.item ?? 0
    }
}

// MARK: - CollectionViewDelegate
extension ImageCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCell(with: indexPath.item)
    }
}

// MARK: - DataSource
extension ImageCollectionView {
    private func configureDataSource() {
        dataSource = photoCollectionViewDataSource()
        configureSnapshot()
    }

    private func photoCollectionViewDataSource() -> UICollectionViewDiffableDataSource<Section, String> {
        return UICollectionViewDiffableDataSource(
            collectionView: photoCollectionView,
            cellProvider: { collectionView, indexPath, item -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
                cell.configureCell(imageURL: item)
                return cell
            })
    }
}

// MARK: - Snapshot
extension ImageCollectionView {
    private func configureSnapshot() {
        snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func reloadURLList(_ items: [String]) {
        let previousImageUrls = snapshot.itemIdentifiers(inSection: .main)
        snapshot.deleteItems(previousImageUrls)
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewLayout
extension ImageCollectionView {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] index, environment -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.53)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.53)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.contentInsets = .zero
            section.interGroupSpacing = .zero
            section.visibleItemsInvalidationHandler = self?.visibleItems()

            return section
        }

        return layout
    }

    private func visibleItems() -> NSCollectionLayoutSectionVisibleItemsInvalidationHandler? {
        return { [weak self] items, offset, environment in
            guard let self = self else { return }
            let width = self.photoCollectionView.bounds.width
            let offset = offset.x
            
            self.pageControlValueDidChange.send((width, offset))
        }
    }
}
