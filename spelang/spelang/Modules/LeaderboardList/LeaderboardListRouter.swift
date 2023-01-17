//
//  LeaderboardListRouter.swift
//  spelang
//
//  Created by Luka Bokarica on 17.01.2023..
//

import Foundation
import UIKit

protocol LeaderboardListRouting {
    var viewController: LeaderboardListViewController? { get set }
    var delegate: LeaderboardListRouterDelegate? { get set }
    
    func navigateToTestLeaderboard(for testName: String)
}

protocol LeaderboardListRouterDelegate: AnyObject {}

final class LeaderboardListRouter: LeaderboardListRouting {
    weak var viewController: LeaderboardListViewController?
    weak var delegate: LeaderboardListRouterDelegate?
    
    func navigateToTestLeaderboard(for testName: String) {
        let router = TestLeaderboardRouter()
        let context = TestLeaderboardContext(testCategoryName: testName)
        let viewModel = TestLeaderboardViewModel(context: context, router: router)
        let viewController = TestLeaderboardViewController(viewModel: viewModel)
        router.viewController = viewController
        
        self.viewController?.navigationController?.present(viewController, animated: true)
    }
}
