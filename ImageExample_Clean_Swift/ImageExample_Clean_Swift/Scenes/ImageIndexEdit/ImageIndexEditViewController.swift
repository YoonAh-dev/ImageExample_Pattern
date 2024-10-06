//
//  ImageIndexEditViewController.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 10/1/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

protocol ImageIndexEditViewDelegate: AnyObject {
    func save(index: Int?)
}

protocol ImageIndexEditDisplayLogic: AnyObject {
    func displayImageIndex(viewModel: ImageIndexEdit.Indexs.ViewModel)
    func displaySaveIndex(viewModel: ImageIndexEdit.SaveIndex.ViewModel)
}

final class ImageIndexEditViewController: UIViewController, ImageIndexEditDisplayLogic {
    
    // MARK: - ui component
    
    private lazy var contentView: ImageIndexEditView = {
        let view = ImageIndexEditView(frame: view.frame)
        view.delegate = self
        return view
    }()
    
    // MARK: - property
    
    private var interactor: ImageIndexEditBusinessLogic?
    var router: (ImageIndexEditRoutingLogic & ImageIndexEditDataPassing)?
    
    // MARK: - init
    
    init(delegate: ImageIndexEditRouterDelegate) {
        super.init(nibName: nil, bundle: nil)
        setup(delegate: delegate)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup
    
    private func setup(delegate: ImageIndexEditRouterDelegate) {
        let viewController = self
        let interactor = ImageIndexEditInteractor()
        let presenter = ImageIndexEditPresenter()
        let router = ImageIndexEditRouter()
        router.delegate = delegate
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
        let request = ImageIndexEdit.Indexs.Request()
        interactor?.start(request: request)
    }
    
    private func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - display - func
    
    public func displayImageIndex(viewModel: ImageIndexEdit.Indexs.ViewModel) {
        contentView.setCounts(viewModel.indexs)
        contentView.setCurrentIndex(viewModel.currentIndex)
    }
    
    public func displaySaveIndex(viewModel: ImageIndexEdit.SaveIndex.ViewModel) {
        guard let index = viewModel.index else {
            showAlert(title: "에러 발생", message: "잘못된 값이 전달되었습니다.")
            return
        }
        router?.routeToImageDetail(with: index)
    }
}

// MARK: - ImageIndexEditViewDelegate
extension ImageIndexEditViewController: ImageIndexEditViewDelegate {
    func save(index: Int?) {
        let request = ImageIndexEdit.SaveIndex.Request(index: index)
        interactor?.save(request: request)
    }
}
