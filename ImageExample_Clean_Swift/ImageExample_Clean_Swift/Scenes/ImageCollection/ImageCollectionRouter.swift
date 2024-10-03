//
//  ImageCollectionRouter.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 9/29/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

protocol ImageCollectionRoutingLogic {
    func routeToImageDetail()
}

protocol ImageCollectionDataPassing {
    var dataStore: ImageCollectionDataStore? { get }
}

final class ImageCollectionRouter: NSObject, ImageCollectionRoutingLogic, ImageCollectionDataPassing {
    weak var viewController: ImageCollectionViewController?
    var dataStore: ImageCollectionDataStore?
    
    // MARK: - route - func
    
    public func routeToImageDetail() {
        let destinationVC = ImageDetailViewController(delegate: self)
        var destinationDS = destinationVC.router!.dataStore!
        passDataToImageDetail(source: dataStore!, destination: &destinationDS)
        navigateToImageDetail(source: viewController!, destination: destinationVC)
    }
    
    // MARK: - navigate - func
    
    private func navigateToImageDetail(source: ImageCollectionViewController, destination: ImageDetailViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - passing data - func
    
    private func passDataToImageDetail(source: ImageCollectionDataStore, destination: inout ImageDetailDataStore) {
        destination.index = source.index
        destination.imageURLs = source.imageURLs
    }
}

extension ImageCollectionRouter: ImageDetailRouterDelegate {
    func dismissWithChange(index: Int) {
        dataStore?.changedIndex = index
    }
}
