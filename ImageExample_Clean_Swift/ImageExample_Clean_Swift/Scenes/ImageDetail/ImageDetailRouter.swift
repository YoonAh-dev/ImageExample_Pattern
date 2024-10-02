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
    func routeToSheetView()
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
        var destinationDS = destinationVC.router!.dataStore!
        passDataToImageCollection(source: dataStore!, destination: &destinationDS)
        navigateToImageCollection(source: viewController!, destination: destinationVC)
    }
    
    public func routeToSheetView() {
        let destinationVC = ImageIndexEditViewController()
        var destinationDS = destinationVC.router!.dataStore!
        if let sheet = destinationVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        passDataToSheetView(source: dataStore!, destination: &destinationDS)
        navigationToSheetView(source: viewController!, destination: destinationVC)
    }
    
    // MARK: - navigate - func
    
    private func navigateToImageCollection(source: ImageDetailViewController, destination: ImageCollectionViewController) {
        source.navigationController?.popViewController(animated: true)
    }
    
    private func navigationToSheetView(source: ImageDetailViewController, destination: ImageIndexEditViewController) {
        source.present(destination, animated: true)
    }
    
    // MARK: - passing data - func
    
    private func passDataToImageCollection(source: ImageDetailDataStore, destination: inout ImageCollectionDataStore) {
        destination.changedIndex = source.index
    }
    
    private func passDataToSheetView(source: ImageDetailDataStore, destination: inout ImageIndexEditDataStore) {
        destination.indexs = Array(source.imageURLs.indices)
        destination.currentIndex = source.index ?? 0
    }
}
