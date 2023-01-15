//
//  TestQuestionRouter.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import UIKit

protocol TestQuestionRouting {
    var viewController: TestQuestionViewController? { get set }
    var delegate: TestQuestionRouterDelegate? { get set }
    
    func navigateToTestResult(questions: [TestQuestion], categoryName: String)
}

protocol TestQuestionRouterDelegate: AnyObject {}

final class TestQuestionRouter: TestQuestionRouting {
    weak var viewController: TestQuestionViewController?
    weak var delegate: TestQuestionRouterDelegate?
    
    func navigateToTestResult(questions: [TestQuestion], categoryName: String) {
        let router = TestResultRouter()
        let context = TestResultContext(questions: questions, categoryName: categoryName)
        let viewModel = TestResultViewModel(context: context, router: router)
        let viewController = TestResultViewController(viewModel: viewModel)
        router.viewController = viewController
        
        self.viewController?.navigationController?.replaceViewControllersStack(with: [viewController])
    }
}
