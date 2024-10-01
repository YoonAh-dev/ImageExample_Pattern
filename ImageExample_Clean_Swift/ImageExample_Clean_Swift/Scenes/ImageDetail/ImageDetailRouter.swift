//
//  ImageDetailRouter.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 10/1/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

protocol ImageDetailRoutingLogic {
    func routeToImageCollection()
}

protocol ImageDetailDataPassing {
    var dataStore: ImageDetailDataStore? { get }
}

final class ImageDetailRouter: NSObject, ImageDetailRoutingLogic, ImageDetailDataPassing
{
    weak var viewController: ImageDetailViewController?
    var dataStore: ImageDetailDataStore?
    
    // MARK: - route - func
    
    public func routeToImageCollection() {
        let destinationVC = ImageCollectionViewController()
        navigateToImageCollection(source: viewController!, destination: destinationVC)
    }
    
    // MARK: - navigate - func
    
    private func navigateToImageCollection(source: ImageDetailViewController, destination: ImageCollectionViewController) {
        source.navigationController?.popViewController(animated: true)
    }
}
