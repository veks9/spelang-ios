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
    
    func navigateToTestResult(questions: [TestQuestion], categoryName: String, rank: Int, difficulty: String)
}

protocol TestQuestionRouterDelegate: AnyObject {}

final class TestQuestionRouter: TestQuestionRouting {
    weak var viewController: TestQuestionViewController?
    weak var delegate: TestQuestionRouterDelegate?
    
    func navigateToTestResult(questions: [TestQuestion], categoryName: String, rank: Int, difficulty: String) {
        let router = TestResultRouter()
        let context = TestResultContext(questions: questions, categoryName: categoryName, rank: rank, difficulty: difficulty)
        let viewModel = TestResultViewModel(context: context, router: router)
        let viewController = TestResultViewController(viewModel: viewModel)
        router.viewController = viewController
        
        self.viewController?.navigationController?.replaceViewControllersStack(with: [viewController])
    }
}
