//
//  ImageDetailPresenter.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 10/1/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

protocol ImageDetailPresentationLogic {
    func presentImage(response: ImageDetail.Image.Response)
    func presentSheetView(response: ImageDetail.EditTap.Response)
    func presentImageCollection(response: ImageDetail.SendIndex.Response)
}

final class ImageDetailPresenter: ImageDetailPresentationLogic {
    
    weak var viewController: ImageDetailDisplayLogic?
    
    // MARK: - public - func
    
    public func presentImage(response: ImageDetail.Image.Response) {
        let viewModel = ImageDetail.Image.ViewModel(imageURL: response.imageURL)
        viewController?.displayImage(viewModel: viewModel)
    }
    
    public func presentSheetView(response: ImageDetail.EditTap.Response) {
        let viewModel = ImageDetail.EditTap.ViewModel(row: response.row, allImageCount: response.allImageCount)
        viewController?.displaySheetView(viewModel: viewModel)
    }
    
    public func presentImageCollection(response: ImageDetail.SendIndex.Response) {
        let viewModel = ImageDetail.SendIndex.ViewModel()
        viewController?.displayImageCollection(viewModel: viewModel)
    }
}

