//
//  TestResultRouter.swift
//  spelang
//
//  Created by Luka Bokarica on 14.01.2023..
//

import Foundation
import UIKit

protocol TestResultRouting {
    var viewController: TestResultViewController? { get set }
    var delegate: TestResultRouterDelegate? { get set }
    
    func navigateToTestList()
    func navigateToTestLeaderboard(categoryName: String, difficulty: String)
}

protocol TestResultRouterDelegate: AnyObject {}

final class TestResultRouter: TestResultRouting {
    weak var viewController: TestResultViewController?
    weak var delegate: TestResultRouterDelegate?
    
    func navigateToTestList() {
        let router = TestListRouter()
        let viewModel = TestListViewModel(router: router)
        let viewController = TestListViewController(viewModel: viewModel)
        router.viewController = viewController
        
        self.viewController?.navigationController?.replaceViewControllersStack(with: [viewController])
    }
    
    func navigateToTestLeaderboard(categoryName: String, difficulty: String) {
        let router = TestLeaderboardRouter()
        let context = TestLeaderboardContext(categoryName: categoryName, difficulty: difficulty)
        let viewModel = TestLeaderboardViewModel(context: context, router: router)
        let viewController = TestLeaderboardViewController(viewModel: viewModel)
        router.viewController = viewController
        
        self.viewController?.navigationController?.present(viewController, animated: true)
    }
}
