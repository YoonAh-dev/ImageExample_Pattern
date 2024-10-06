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

protocol ImageDetailRouterDelegate: AnyObject {
    func dismissWithChange(index: Int)
}

final class ImageDetailRouter: ImageDetailRoutingLogic, ImageDetailDataPassing {
    
    weak var viewController: ImageDetailViewController?
    var dataStore: ImageDetailDataStore?
    weak var delegate: ImageDetailRouterDelegate?
    
    // MARK: - route - func
    
    public func routeToImageCollection() {
        let destinationVC = ImageCollectionViewController()
        navigateToImageCollection(source: viewController!, destination: destinationVC)
    }
    
    public func routeToSheetView() {
        let destinationVC = ImageIndexEditViewController(delegate: self)
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
        if let index = dataStore?.index {
            delegate?.dismissWithChange(index: index)
        }
        source.navigationController?.popViewController(animated: true)
    }
    
    private func navigationToSheetView(source: ImageDetailViewController, destination: ImageIndexEditViewController) {
        source.present(destination, animated: true)
    }
    
    // MARK: - passing data - func
    
    private func passDataToSheetView(source: ImageDetailDataStore, destination: inout ImageIndexEditDataStore) {
        destination.indexs = Array(source.imageURLs.indices)
        destination.currentIndex = source.index ?? 0
    }
}

extension ImageDetailRouter: ImageIndexEditRouterDelegate {
    func dismissWithSuccess(changedIndex: Int) {
        self.dataStore?.index = changedIndex
    }
}
