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
    func presentSomething(response: ImageCollection.Something.Response)
}

final class ImageCollectionPresenter: ImageCollectionPresentationLogic {
    
    weak var viewController: ImageCollectionDisplayLogic?
    
    // MARK: - public - func
    
    public func presentSomething(response: ImageCollection.Something.Response) {
        let viewModel = ImageCollection.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
