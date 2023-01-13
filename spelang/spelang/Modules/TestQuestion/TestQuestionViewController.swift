//
//  TestQuestionViewController.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import UIKit

final class TestQuestionViewController: UIViewController {
    
    private var viewModel: TestQuestionViewModeling
    
    // MARK: - Views
    
    // MARK: - Lifecycle
    
    init(viewModel: TestQuestionViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        observe()
    }
    
    private func addSubviews() {
    }
    
    private func setConstraints() {
    }
    
    private func observe() {
    }
}

// MARK: - TestListRouterDelegate

extension TestQuestionViewController: TestQuestionRouterDelegate {}
