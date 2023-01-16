//
//  TestListRouter.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import UIKit

protocol TestListRouting {
    var viewController: TestListViewController? { get set }
    var delegate: TestListRouterDelegate? { get set }
    
    func navigateToTestQuestion()
    func navigateToLeaderBoards()
}

protocol TestListRouterDelegate: AnyObject {}

final class TestListRouter: TestListRouting {
    weak var viewController: TestListViewController?
    weak var delegate: TestListRouterDelegate?
    
    func navigateToTestQuestion() {
        let router = TestQuestionRouter()
        let context = TestQuestionContext(
            questions: [
                TestQuestion(
                    word: "mačka",
                    translation: "cat",
                    answer: nil
                ),
                TestQuestion(
                    word: "pas",
                    translation: "dog",
                    answer: nil
                ),
                TestQuestion(
                    word: "konj",
                    translation: "horse",
                    answer: nil
                ),
                TestQuestion(
                    word: "slon",
                    translation: "elephant",
                    answer: nil
                )
            ],
            categoryName: "Animals"
        )
        let viewModel = TestQuestionViewModel(context: context, router: router)
        let viewController = TestQuestionViewController(viewModel: viewModel)
        
        router.viewController = viewController
        router.delegate = viewController
        
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateToLeaderBoards() {
        // TODO: - implement this
    }
}
