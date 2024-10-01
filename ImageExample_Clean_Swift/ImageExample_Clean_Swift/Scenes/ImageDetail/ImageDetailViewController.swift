//
//  ImageDetailViewController.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 10/1/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

protocol ImageDetailDisplayLogic: AnyObject {
    func displayImage(viewModel: ImageDetail.Image.ViewModel)
}

final class ImageDetailViewController: UIViewController, ImageDetailDisplayLogic {
    
    // MARK: - ui component
    
    private lazy var contentView = ImageDetailView(frame: view.frame)
    
    // MARK: - property
    
    private var interactor: ImageDetailBusinessLogic?
    
    var router: (ImageDetailRoutingLogic & ImageDetailDataPassing)?
    
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
        let interactor = ImageDetailInteractor()
        let presenter = ImageDetailPresenter()
        let router = ImageDetailRouter()
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
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
    
    // MARK: - func
    
    private func start() {
        let request = ImageDetail.Image.Request()
        interactor?.fetchImage(request: request)
    }
    
    // MARK: - display - func
    
    public func displayImage(viewModel: ImageDetail.Image.ViewModel) {
        guard let imageURL = viewModel.imageURL else {
            router?.routeToImageCollection()
            return
        }
        contentView.updateImage(imageURL)
    }
}
