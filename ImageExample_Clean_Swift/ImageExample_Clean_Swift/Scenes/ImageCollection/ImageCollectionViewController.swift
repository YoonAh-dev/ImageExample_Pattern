//
//  ImageCollectionViewController.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 9/29/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

protocol ImageCollectionDisplayLogic: AnyObject {
    func displaySomething(viewModel: ImageCollection.Something.ViewModel)
}

final class ImageCollectionViewController: UIViewController, ImageCollectionDisplayLogic {
    
    // MARK: - property
    
    private var interactor: ImageCollectionBusinessLogic?
    private var router: (ImageCollectionRoutingLogic & ImageCollectionDataPassing)?
    
    // MARK: - init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup
    
    private func setup() {
        let viewController = self
        let interactor = ImageCollectionInteractor()
        let presenter = ImageCollectionPresenter()
        let router = ImageCollectionRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - lifecycle
    
    override func loadView() {
        super.loadView()
        view = ImageCollectionView(frame: view.frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }
    
    // MARK: - func
    
    private func doSomething() {
        let request = ImageCollection.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    // MARK: - display - func
    
    public func displaySomething(viewModel: ImageCollection.Something.ViewModel) {
        
    }
}
