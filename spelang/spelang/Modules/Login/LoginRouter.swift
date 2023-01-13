//
//  LoginRouter.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import UIKit

protocol LoginRouting {
    var viewController: LoginViewController? { get set }
    var delegate: LoginRouterDelegate? { get set }
}

protocol LoginRouterDelegate: AnyObject {}

final class LoginRouter: LoginRouting {
    weak var viewController: LoginViewController?
    weak var delegate: LoginRouterDelegate?
}
