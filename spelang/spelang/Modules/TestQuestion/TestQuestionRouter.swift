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
}

protocol TestQuestionRouterDelegate: AnyObject {}

final class TestQuestionRouter: TestQuestionRouting {
    weak var viewController: TestQuestionViewController?
    weak var delegate: TestQuestionRouterDelegate?
}
