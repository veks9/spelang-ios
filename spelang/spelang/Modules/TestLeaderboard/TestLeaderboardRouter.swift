//
//  TestLeaderboardRouter.swift
//  spelang
//
//  Created by Luka Bokarica on 16.01.2023..
//

import Foundation
import UIKit

protocol TestLeaderboardRouting {
    var viewController: TestLeaderboardViewController? { get set }
    var delegate: TestLeaderboardRouterDelegate? { get set }
}

protocol TestLeaderboardRouterDelegate: AnyObject {}

final class TestLeaderboardRouter: TestLeaderboardRouting {
    weak var viewController: TestLeaderboardViewController?
    weak var delegate: TestLeaderboardRouterDelegate?
}
