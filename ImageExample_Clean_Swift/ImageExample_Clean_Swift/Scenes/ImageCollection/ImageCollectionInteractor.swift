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
    func didSelectPhoto(request: ImageCollection.PhotoSelection.Request)
    func changeIndexs(request: ImageCollection.PhotoCollection.Request)
}

protocol ImageCollectionDataStore {
    var count: Int { get set }
    var index: Int? { get set }
    var changedIndex: Int? { get set }
    var imageURLs: [String] { get }
}

final class ImageCollectionInteractor: ImageCollectionBusinessLogic, ImageCollectionDataStore {

    // MARK: - datastore - property
    
    var count: Int = 0
    var index: Int?
    var changedIndex: Int?
    var imageURLs: [String] = []
    
    // MARK: - property
    
    private let maxCount = 30
    
    var presenter: ImageCollectionPresentationLogic?
    
    let photosWorker: PhotosWorker
    
    // MARK: - init
    
    init(photosWorker: PhotosWorker) {
        self.photosWorker = photosWorker
    }
    
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
            if count > maxCount { count = maxCount }
        }
        let response = ImageCollection.PhotoCollectionCount.Response(count: count)
        presenter?.presentCount(response: response)
    }
    
    public func fetchPhotoCollection(request: ImageCollection.PhotoCollection.Request) {
        Task { [weak self] in
            guard let self, self.count > 0 else { return }
            let urls = await self.photosWorker.fetchRandomPhotoURLs(count: self.count)
            let response = ImageCollection.PhotoCollection.Response(photoURLs: urls)
            self.imageURLs = urls
            self.presenter?.presentPhotoCollection(response: response)
        }
    }
    
    public func changeToPage(request: ImageCollection.PhotoCollectionPage.Request) {
        let width = request.width
        let offset = request.offset
        let page = Int(offset / width)
        let response = ImageCollection.PhotoCollectionPage.Response(page: page)
        presenter?.presentCurrentPage(response: response)
    }
    
    public func didSelectPhoto(request: ImageCollection.PhotoSelection.Request) {
        guard imageURLs.isNotEmpty(), imageURLs.count > request.row else { return }
        index = request.row
        changedIndex = request.row
        
        let response = ImageCollection.PhotoSelection.Response()
        presenter?.presentSelectedPhoto(response: response)
    }
    
    public func changeIndexs(request: ImageCollection.PhotoCollection.Request) {
        guard let index, let changedIndex, imageURLs.isNotEmpty() else { return }
        guard index != changedIndex else { return }
        
        let element = imageURLs.remove(at: index)
        imageURLs.insert(element, at: changedIndex)
        let response = ImageCollection.PhotoCollection.Response(photoURLs: imageURLs)
        presenter?.presentPhotoCollection(response: response)
    }
}
