//
//  ImageCollectionViewController.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 9/29/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import Combine
import UIKit

protocol ImageCollectionViewDelegate: AnyObject {
    func didSelectCell(with rowIndex: Int)
}

protocol ImageCollectionDisplayLogic: AnyObject {
    func displayCount(viewModel: ImageCollection.PhotoCollectionCount.ViewModel)
    func displayPhotoCollection(viewModel: ImageCollection.PhotoCollection.ViewModel)
    func displayCurrentPage(viewModel: ImageCollection.PhotoCollectionPage.ViewModel)
    func displaySelectedPhoto(viewModel: ImageCollection.PhotoSection.ViewModel)
}

final class ImageCollectionViewController: UIViewController, ImageCollectionDisplayLogic {
    
    // MARK: - ui component
    
    private lazy var contentView: ImageCollectionView = {
        let view = ImageCollectionView(frame: view.frame)
        view.delegate = self
        return view
    }()
    
    // MARK: - property
    
    private var cancellables: Set<AnyCancellable> = []
    
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
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
        setupAction()
    }
    
    // MARK: - func
    
    private func setupAction() {
        contentView.leftButtonTapGesture
            .sink { [weak self] in
                self?.tapLeftButton()
            }.store(in: &cancellables)
        
        contentView.rightButtonTapGesture
            .sink { [weak self] in
                self?.tapRightButton()
            }.store(in: &cancellables)
        
        contentView.submitButtonTapGesture
            .sink { [weak self] in
                self?.tapSubmitButton()
            }.store(in: &cancellables)
        
        contentView.pageControlValueDidChange
            .sink { [weak self] value in
                self?.scrollCollectionView(width: value.width, offset: value.offset)
            }.store(in: &cancellables)
    }
    
    // MARK: - component - func
    
    private func start() {
        interactor?.start()
    }
    
    private func tapLeftButton() {
        let request = ImageCollection.PhotoCollectionCount.Request(direction: .left)
        interactor?.changeCount(request: request)
    }
    
    private func tapRightButton() {
        let request = ImageCollection.PhotoCollectionCount.Request(direction: .right)
        interactor?.changeCount(request: request)
    }
    
    private func tapSubmitButton() {
        let request = ImageCollection.PhotoCollection.Request()
        interactor?.fetchPhotoCollection(request: request)
    }
    
    private func scrollCollectionView(width: Double, offset: Double) {
        let request = ImageCollection.PhotoCollectionPage.Request(width: width, offset: offset)
        interactor?.changeToPage(request: request)
    }
    
    // MARK: - display - func
    
    public func displayCount(viewModel: ImageCollection.PhotoCollectionCount.ViewModel) {
        contentView.setupCountLabel(count: viewModel.count)
    }
    
    public func displayPhotoCollection(viewModel: ImageCollection.PhotoCollection.ViewModel) {
        contentView.setupPhotoCollectionView(photoURLs: viewModel.photoURLs)
    }
    
    public func displayCurrentPage(viewModel: ImageCollection.PhotoCollectionPage.ViewModel) {
        contentView.setupCurrentPage(index: viewModel.page)
    }
    
    public func displaySelectedPhoto(viewModel: ImageCollection.PhotoSection.ViewModel) {
        router?.routeToImageDetail()
    }
}

// MARK: - ImageCollectionViewDelegate
extension ImageCollectionViewController: ImageCollectionViewDelegate {
    func didSelectCell(with rowIndex: Int) {
        let request = ImageCollection.PhotoSection.Request(row: rowIndex)
        interactor?.didSelectPhoto(request: request)
    }
}
