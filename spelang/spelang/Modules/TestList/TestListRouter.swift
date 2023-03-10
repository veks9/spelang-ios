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
    
    func navigateToTestQuestion(categoryName: String, difficulty: String)
    func navigateToLeaderBoards(with context: Model.TestLeaderboards)
    func navigateToLogin()
}

protocol TestListRouterDelegate: AnyObject {}

final class TestListRouter: TestListRouting {
    weak var viewController: TestListViewController?
    weak var delegate: TestListRouterDelegate?
    
    func navigateToTestQuestion(categoryName: String, difficulty: String) {
        let router = TestQuestionRouter()
        let context = TestQuestionContext(categoryName: categoryName, difficulty: difficulty)
        let viewModel = TestQuestionViewModel(context: context, router: router)
        let viewController = TestQuestionViewController(viewModel: viewModel)
        
        router.viewController = viewController
        router.delegate = viewController
        
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateToLeaderBoards(with leaderboard: Model.TestLeaderboards) {
        let router = LeaderboardListRouter()
        let context = LeaderboardListContext(leaderboard: leaderboard)
        let viewModel = LeaderboardListViewModel(router: router, context: context)
        let viewController = LeaderboardListViewController(viewModel: viewModel)
        router.viewController = viewController
        
        self.viewController?.navigationController?.pushViewController(viewController, animated: false)
    }
    
    func navigateToLogin() {
        let router = LoginRouter()
        let viewModel = LoginViewModel(router: router)
        let viewController = LoginViewController(viewModel: viewModel)

        router.viewController = viewController
        router.delegate = viewController
        
        self.viewController?.navigationController?.replaceViewControllersStack(with: [viewController], animated: false)
    }
}
