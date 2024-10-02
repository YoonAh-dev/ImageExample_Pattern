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
}

protocol ImageIndexEditDataPassing {
    var dataStore: ImageIndexEditDataStore? { get }
}

final class ImageIndexEditRouter: NSObject, ImageIndexEditRoutingLogic, ImageIndexEditDataPassing
{
    weak var viewController: ImageIndexEditViewController?
    var dataStore: ImageIndexEditDataStore?
    
    // MARK: - route - func
    
    public func routeToImageDetail() {
        let destinationVC = ImageDetailViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToImageDetail(source: dataStore!, destination: &destinationDS)
        navigateToImageDetail(source: viewController!, destination: destinationVC)
    }
    
    // MARK: - navigate - func
    
    private func navigateToImageDetail(source: ImageIndexEditViewController, destination: ImageDetailViewController) {
        source.dismiss(animated: true)
    }
    
    // MARK: - passing data - func
    
    private func passDataToImageDetail(source: ImageIndexEditDataStore, destination: inout ImageDetailDataStore) {
        destination.index = source.currentIndex
    }
}

