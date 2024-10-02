//
//  ImageIndexEditPresenter.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 10/1/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

protocol ImageIndexEditPresentationLogic {
    func presentIndexs(response: ImageIndexEdit.Indexs.Response)
    func presentSaveState(response: ImageIndexEdit.SaveIndex.Response)
}

final class ImageIndexEditPresenter: ImageIndexEditPresentationLogic {
    
    weak var viewController: ImageIndexEditDisplayLogic?
    
    // MARK: - public - func
    
    public func presentIndexs(response: ImageIndexEdit.Indexs.Response) {
        let viewModel = ImageIndexEdit.Indexs.ViewModel(
            indexs: response.indexs.compactMap { String($0) },
            currentIndex: response.currentIndex
        )
        viewController?.displayImageIndex(viewModel: viewModel)
    }
    
    public func presentSaveState(response: ImageIndexEdit.SaveIndex.Response) {
        let viewModel = ImageIndexEdit.SaveIndex.ViewModel(index: response.index)
        viewController?.displaySaveIndex(viewModel: viewModel)
    }
}
