//
//  ImageCollectionView.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 9/29/24.
//

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
        return collectionView
    }()
    private let pageControl: UIPageControl = UIPageControl()
    private let photoCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
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
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    private var snapshot: NSDiffableDataSourceSnapshot<Section, String>!
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addSubViews()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
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
            $0.top.equalTo(photoCollectionView.snp.bottom).offset(-10)
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
}

// MARK: - DataSource
extension ImageCollectionView {
    private func configureDataSource() {
        self.dataSource = self.photoCollectionViewDataSource()
        self.configureSnapshot()
    }

    private func photoCollectionViewDataSource() -> UICollectionViewDiffableDataSource<Section, String> {
        return UICollectionViewDiffableDataSource(
            collectionView: self.photoCollectionView,
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
        self.snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        self.snapshot.appendSections([.main])
        self.dataSource.apply(self.snapshot, animatingDifferences: true)
    }

    private func reloadUrlList(_ items: [String]) {
        let previousImageUrls = self.snapshot.itemIdentifiers(inSection: .main)
        self.snapshot.deleteItems(previousImageUrls)
        self.snapshot.appendItems(items, toSection: .main)
        self.dataSource.apply(self.snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewLayout
extension ImageCollectionView {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { index, environment -> NSCollectionLayoutSection? in
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
            section.visibleItemsInvalidationHandler = self.visibleItems()

            return section
        }

        return layout
    }

    private func visibleItems() -> NSCollectionLayoutSectionVisibleItemsInvalidationHandler? {
        return { [weak self] items, offset, environment in
            guard let self = self else { return }
            let width = self.photoCollectionView.bounds.width
            let offset = offset.x
            
//            self.didScrollSubject.send((width, offset))
        }
    }
}
