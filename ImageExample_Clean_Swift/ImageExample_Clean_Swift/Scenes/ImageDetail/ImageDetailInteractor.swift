//
//  ImageDetailInteractor.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 10/1/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

protocol ImageDetailBusinessLogic {
    func fetchImage(request: ImageDetail.Image.Request)
    func didTapEdit(request: ImageDetail.EditTap.Request)
    func sendIndex(request: ImageDetail.SendIndex.Request)
}

protocol ImageDetailDataStore {
    var imageURLs: [String] { get set }
    var index: Int? { get set }
}

final class ImageDetailInteractor: ImageDetailBusinessLogic, ImageDetailDataStore {
    
    // MARK: - datasource - property
    
    var imageURLs: [String] = []
    var index: Int?
    
    // MARK: - property
    
    var presenter: ImageDetailPresentationLogic?
    
    // MARK: - public - func
    
    public func fetchImage(request: ImageDetail.Image.Request) {
        let imageURL: String? = if let index { imageURLs[safe: index] }
        else { nil }
        let response = ImageDetail.Image.Response(imageURL: imageURL)
        presenter?.presentImage(response: response)
    }
    
    public func didTapEdit(request: ImageDetail.EditTap.Request) {
        guard let index else { return }
        let response = ImageDetail.EditTap.Response(row: index, allImageCount: imageURLs.count)
        presenter?.presentSheetView(response: response)
    }
    
    public func sendIndex(request: ImageDetail.SendIndex.Request) {
        let response = ImageDetail.SendIndex.Response()
        presenter?.presentImageCollection(response: response)
    }
}
