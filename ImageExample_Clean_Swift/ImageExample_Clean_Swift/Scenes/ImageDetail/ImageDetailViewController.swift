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
    
    init(delegate: ImageDetailRouterDelegate) {
        super.init(nibName: nil, bundle: nil)
        setup(delegate: delegate)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup
    
    private func setup(delegate: ImageDetailRouterDelegate) {
        let viewController = self
        let interactor = ImageDetailInteractor()
        let presenter = ImageDetailPresenter()
        let router = ImageDetailRouter()
        router.delegate = delegate
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(didTapEdit)
        )
    }
    
    // MARK: - selector
    
    @objc
    private func didTapEdit() {
        router?.routeToSheetView()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isMovingFromParent()
    }
    
    // MARK: - func
    
    private func start() {
        let request = ImageDetail.Image.Request()
        interactor?.fetchImage(request: request)
    }
    
    private func isMovingFromParent() {
        if isMovingFromParent {
            router?.routeToImageCollection()
        }
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
