//
//  ImageIndexEditView.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 10/1/24.
//

import Combine
import UIKit
import SnapKit

final class ImageIndexEditView: UIView {

    // MARK: - ui component
    
    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    // MARK: - property
    
    weak var delegate: ImageIndexEditViewDelegate?
    
    private var counts: [String] = []
    
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupLayout()
        setupAction()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup
    
    private func configureUI() {
        backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        addSubview(picker)
        addSubview(saveButton)
        
        picker.snp.makeConstraints {
            $0.directionalVerticalEdges.equalToSuperview().inset(100)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupAction() {
        saveButton
            .tapPublisher
            .sink { [weak self] in
                let index = self?.picker.selectedRow(inComponent: 0)
                self?.delegate?.save(index: index)
            }.store(in: &cancellables)
    }
    
    // MARK: - public - func
    
    public func setCounts(_ counts: [String]) {
        self.counts = counts
        picker.reloadAllComponents()
    }
    
    public func setCurrentIndex(_ index: Int) {
        picker.selectRow(index, inComponent: 0, animated: false)
    }
}

// MARK: - UIPickerViewDataSource
extension ImageIndexEditView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return counts.count
    }
}

// MARK: - UIPickerViewDelegate
extension ImageIndexEditView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return counts[row]
    }
}
