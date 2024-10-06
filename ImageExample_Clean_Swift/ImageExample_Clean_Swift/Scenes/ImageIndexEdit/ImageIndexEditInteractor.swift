//
//  ImageIndexEditInteractor.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 10/1/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

protocol ImageIndexEditBusinessLogic {
    func start(request: ImageIndexEdit.Indexs.Request)
    func save(request: ImageIndexEdit.SaveIndex.Request)
}

protocol ImageIndexEditDataStore {
    var indexs: [Int] { get set }
    var currentIndex: Int { get set }
}

final class ImageIndexEditInteractor: ImageIndexEditBusinessLogic, ImageIndexEditDataStore {
    
    // MARK: - datasource - property
    
    var indexs: [Int] = []
    var currentIndex: Int = 0
    
    // MARK: - property
    
    var presenter: ImageIndexEditPresentationLogic?
    
    // MARK: - public - func
    
    public func start(request: ImageIndexEdit.Indexs.Request) {
        let response = ImageIndexEdit.Indexs.Response(indexs: indexs, currentIndex: currentIndex)
        presenter?.presentIndexs(response: response)
    }
    
    public func save(request: ImageIndexEdit.SaveIndex.Request) {
        let response = ImageIndexEdit.SaveIndex.Response(index: request.index)
        currentIndex = request.index ?? currentIndex
        presenter?.presentSaveState(response: response)
    }
}
