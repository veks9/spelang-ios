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

// MARK: - Private methods

private extension AppDelegate {
    func disableSnapKitMessagesInsideDebugger() {
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    }
    
//    func createRootViewController() -> UIViewController {
//        let router = LoginRouter()
//        let viewModel = LoginViewModel(router: router)
//        let viewController = LoginViewController(viewModel: viewModel)
//
//        router.viewController = viewController
//        router.delegate = viewController
//
//        return viewController
//    }
    
    func createRootViewController() -> UIViewController {
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
        
        return viewController
    }
}
