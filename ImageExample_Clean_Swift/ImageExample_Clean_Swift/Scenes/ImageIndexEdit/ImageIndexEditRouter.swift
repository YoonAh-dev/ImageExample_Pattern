//
//  ImageIndexEditRouter.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 10/1/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

protocol ImageIndexEditRoutingLogic {
    func routeToImageDetail()
    func routeToImageDetail(with changedIndex: Int)
}

protocol ImageIndexEditDataPassing {
    var dataStore: ImageIndexEditDataStore? { get }
}

protocol ImageIndexEditRouterDelegate: AnyObject {
    func dismissWithSuccess(changedIndex: Int)
}

final class ImageIndexEditRouter: ImageIndexEditRoutingLogic, ImageIndexEditDataPassing {
    
    weak var viewController: ImageIndexEditViewController?
    var dataStore: ImageIndexEditDataStore?
    weak var delegate: ImageIndexEditRouterDelegate?
    
    // MARK: - route - func
    
    public func routeToImageDetail() {
        navigateToImageDetail(source: viewController!)
    }
    
    public func routeToImageDetail(with changedIndex: Int) {
        delegate?.dismissWithSuccess(changedIndex: changedIndex)
        viewController?.dismiss(animated: true)
    }
    
    // MARK: - navigate - func
    
    private func navigateToImageDetail(source: ImageIndexEditViewController) {
        source.dismiss(animated: true)
    }
}
