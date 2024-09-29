//
//  ImageCollectionInteractor.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 9/29/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

protocol ImageCollectionBusinessLogic {
    func doSomething(request: ImageCollection.Something.Request)
}

protocol ImageCollectionDataStore {
    //var name: String { get set }
}

final class ImageCollectionInteractor: ImageCollectionBusinessLogic, ImageCollectionDataStore {
    
    // MARK: - property
    
    var presenter: ImageCollectionPresentationLogic?
    
//    private var worker: ImageCollectionWorker?
    
    //var name: String = ""
    
    // MARK: - public - func
    
    public func doSomething(request: ImageCollection.Something.Request) {
//        worker = ImageCollectionWorkerImpl()
//        worker?.doSomeWork()
        
        let response = ImageCollection.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
