//
//  AppDelegate.swift
//  spelang
//
//  Created by Vedran Hernaus on 19.12.2022..
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        disableSnapKitMessagesInsideDebugger()
        window?.rootViewController = UINavigationController(rootViewController: createRootViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
}

// MARK: - Private functions

private extension AppDelegate {
    func disableSnapKitMessagesInsideDebugger() {
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    }
    
    func createRootViewController() -> UIViewController {
        let router = LoginRouter()
        let viewModel = LoginViewModel(router: router)
        let viewController = LoginViewController(viewModel: viewModel)
        
        router.viewController = viewController
        router.delegate = viewController
        
        return viewController
    }
}
