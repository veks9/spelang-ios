//
//  TestListViewController.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import UIKit

final class TestListViewController: UIViewController {
    
    private var viewModel: TestListViewModeling
    
    // MARK: - Views
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: TestListViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setConstraints()
        observe()
    }
    
    private func setupView() {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
    }
    
    private func addSubviews() {
        view.addSubview(button)
    }
    
    private func setConstraints() {
        button.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(50)
        }
    }
    
    private func observe() {
        button.onTap { [weak self] in
            guard let self = self else { return }
            self.viewModel.navigate()
        }
    }
}

// MARK: - TestListRouterDelegate

extension TestListViewController: TestListRouterDelegate {}
