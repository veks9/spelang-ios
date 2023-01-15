//
//  TestResultDetailsView.swift
//  spelang
//
//  Created by Luka Bokarica on 15.01.2023..
//

import Foundation
import UIKit

final class TestResultDetailsView: UIView {
    
    // TODO: FIX THIS (MAKE PRIVATE)
    var viewModel: TestResultDetailsViewModel?
    
    // MARK: - Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        
        return blurEffectView
    }()
    
    private lazy var closeTestResultDetailsButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(Assets.closeIcon.image, for: .normal)
        
        return button
    }()
    
    private lazy var testResultDetailsLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 30, weight: .bold))
        label.text = "test_result_details_label_title".localized()
        
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self.viewModel?.dataSource
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.alwaysBounceVertical = false
        
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
        observe()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(blurEffectView)
        containerView.addSubview(closeTestResultDetailsButton)
        containerView.addSubview(testResultDetailsLabel)
    }
    
    private func setConstraints() {
        containerView.snp.remakeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(600)
        }
        
        blurEffectView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        closeTestResultDetailsButton.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.width.equalTo(20)
        }
        
        testResultDetailsLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(70)
        }
    }
    
    private func observe() {
        closeTestResultDetailsButton.onTap { [weak self] in
            guard let self = self else { return }
            self.viewModel?.closeTestResultDetailsButtonTapped()
        }
    }
}

// MARK: - Public functions

extension TestResultDetailsView {
    func updateUI(viewModel: TestResultDetailsViewModel) {
        self.viewModel = viewModel
    }
}
