//
//  ImageDetailView.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 10/1/24.
//

import UIKit
import SnapKit

final class ImageDetailView: UIView {
    
    // MARK: - ui component
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup
    
    private func configureUI() {
        backgroundColor = .systemGray
    }

    private func setupLayout() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - public - func
    
    public func updateImage(_ imageURL: String) {
        DispatchQueue.main.async { [weak imageView] in
            imageView?.loadImageUrl(imageURL)
        }
    }
}
