//
//  ImageCollectionPresenter.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 9/29/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

protocol ImageCollectionPresentationLogic {
    func presentCount(response: ImageCollection.PhotoCollectionCount.Response)
    func presentPhotoCollection(response: ImageCollection.PhotoCollection.Response)
    func presentCurrentPage(response: ImageCollection.PhotoCollectionPage.Response)
    func presentSelectedPhoto(response: ImageCollection.PhotoSection.Response)
}

final class ImageCollectionPresenter: ImageCollectionPresentationLogic {
    
    weak var viewController: ImageCollectionDisplayLogic?
    
    // MARK: - public - func
    
    func presentCount(response: ImageCollection.PhotoCollectionCount.Response) {
        let countString = String(response.count)
        let viewModel = ImageCollection.PhotoCollectionCount.ViewModel(count: countString)
        viewController?.displayCount(viewModel: viewModel)
    }
    
    func presentPhotoCollection(response: ImageCollection.PhotoCollection.Response) {
        let viewModel = ImageCollection.PhotoCollection.ViewModel(photoURLs: response.photoURLs)
        viewController?.displayPhotoCollection(viewModel: viewModel)
    }
    
    func presentCurrentPage(response: ImageCollection.PhotoCollectionPage.Response) {
        let viewModel = ImageCollection.PhotoCollectionPage.ViewModel(page: response.page)
        viewController?.displayCurrentPage(viewModel: viewModel)
    }
    
    func presentSelectedPhoto(response: ImageCollection.PhotoSection.Response) {
        let viewModel = ImageCollection.PhotoSection.ViewModel()
        viewController?.displaySelectedPhoto(viewModel: viewModel)
    }
}
