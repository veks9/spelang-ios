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
    
    func navigateToTestList()
}

protocol LoginRouterDelegate: AnyObject {}

final class LoginRouter: LoginRouting {
    weak var viewController: LoginViewController?
    weak var delegate: LoginRouterDelegate?
    
    func navigateToTestList() {
        let router = TestListRouter()
        let viewModel = TestListViewModel(router: router)
        let viewController = TestListViewController(viewModel: viewModel)
        router.viewController = viewController
        
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
