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
    func start()
    func changeCount(request: ImageCollection.PhotoCollectionCount.Request)
    func fetchPhotoCollection(request: ImageCollection.PhotoCollection.Request)
    func changeToPage(request: ImageCollection.PhotoCollectionPage.Request)
}

protocol ImageCollectionDataStore {
    var count: Int { get set }
}

final class ImageCollectionInteractor: ImageCollectionBusinessLogic, ImageCollectionDataStore {

    // MARK: - datastore - property
    
    var count: Int = 0
    
    // MARK: - property
    
    let photosWorker = PhotosWorkerImpl(unsplashAPI: UnsplashAPI())
    
    var presenter: ImageCollectionPresentationLogic?
    
    // MARK: - public - func
    
    public func start() {
        let response = ImageCollection.PhotoCollectionCount.Response(count: count)
        presenter?.presentCount(response: response)
    }
    
    public func changeCount(request: ImageCollection.PhotoCollectionCount.Request) {
        switch request.direction {
        case .left:
            if count == 0 { return }
            count -= 1
        case .right:
            count += 1
        }
        let response = ImageCollection.PhotoCollectionCount.Response(count: count)
        presenter?.presentCount(response: response)
    }
    
    public func fetchPhotoCollection(request: ImageCollection.PhotoCollection.Request) {
        Task { [weak photosWorker, presenter] in
            let urls = await photosWorker?.fetchRandomPhotoURLs(count: count) ?? []
            let response = ImageCollection.PhotoCollection.Response(photoURLs: urls)
            presenter?.presentPhotoCollection(response: response)
        }
    }
    
    public func changeToPage(request: ImageCollection.PhotoCollectionPage.Request) {
        let width = request.width
        let offset = request.offset
        let page = Int(offset / width)
        let response = ImageCollection.PhotoCollectionPage.Response(page: page)
        presenter?.presentCurrentPage(response: response)
    }
}
