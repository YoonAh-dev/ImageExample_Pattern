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
}

protocol ImageDetailDataStore {
    var imageURL: String? { get set }
}

final class ImageDetailInteractor: ImageDetailBusinessLogic, ImageDetailDataStore {
    
    // MARK: - datasource - property
    
    var imageURL: String?
    
    // MARK: - property
    
    var presenter: ImageDetailPresentationLogic?
    
    // MARK: - public - func
    
    public func fetchImage(request: ImageDetail.Image.Request) {
        let response = ImageDetail.Image.Response(imageURL: imageURL)
        presenter?.presentImage(response: response)
    }
}
