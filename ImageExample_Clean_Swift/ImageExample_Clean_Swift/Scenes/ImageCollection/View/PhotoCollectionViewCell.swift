//
//  PhotoCollectionViewCell.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 9/29/24.
//

import UIKit
import SnapKit

final class PhotoCollectionViewCell: UICollectionViewCell {

    static let identifier = "PhotoCollectionViewCell"

    // MARK: - ui component

    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup
    
    private func setupLayout() {
        addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
    }

    // MARK: - func

    func configureCell(imageURL: String) {
        photoImageView.loadImageUrl(imageURL)
    }
}
