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
}

protocol TestResultRouterDelegate: AnyObject {}

final class TestResultRouter: TestResultRouting {
    weak var viewController: TestResultViewController?
    weak var delegate: TestResultRouterDelegate?
}
