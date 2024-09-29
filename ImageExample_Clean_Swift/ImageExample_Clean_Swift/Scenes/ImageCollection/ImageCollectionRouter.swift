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
    func routeToSomewhere()
}

protocol ImageCollectionDataPassing {
    var dataStore: ImageCollectionDataStore? { get }
}

final class ImageCollectionRouter: NSObject, ImageCollectionRoutingLogic, ImageCollectionDataPassing {
    weak var viewController: ImageCollectionViewController?
    var dataStore: ImageCollectionDataStore?
    
    // MARK: - route - func
    
    public func routeToSomewhere() {
//        let destinationVC = SomewhereViewController()
//        var destinationDS = destinationVC.router!.dataStore!
//        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//        navigateToSomewhere(source: viewController!, destination: destinationVC)
    }
    
    // MARK: - navigate - func
    
//    private func navigateToSomewhere(source: ImageCollectionViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }
    
    // MARK: - passing data - func
    
//    private func passDataToSomewhere(source: ImageCollectionDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }
}
