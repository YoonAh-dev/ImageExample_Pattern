//
//  PhotoCollectionViewDataSource.swift
//  ImageExample_MVVM_Combine
//
//  Created by SHIN YOON AH on 2023/06/13.
//

import UIKit

final class PhotoCollectionViewDataSource<Cell: UICollectionViewCell, T>: NSObject, UICollectionViewDataSource {

    private let identifier: String
    private let items: [T]
    private let configureCell: ((Cell, T) -> Void)?

    init(identifier: String, items: [T], configureCell: ((Cell, T) -> Void)? = nil) {
        self.identifier = identifier
        self.items = items
        self.configureCell = configureCell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as? Cell else { return UICollectionViewCell() }
        let item = self.items[indexPath.row]

        self.configureCell?(cell, item)

        return cell
    }
}

