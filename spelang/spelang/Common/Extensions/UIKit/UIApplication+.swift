//
//  UIApplication+.swift
//  Ohmics
//
//  Created by Krešimir Baković on 17/04/2021.
//  Copyright © 2021 Kreso Bakovic. All rights reserved.
//

import UIKit

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.appWindow.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    static var appWindow: UIWindow {
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIWindow()
    }
}

extension UIApplication {
    func openAppSettings() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString + Bundle.main.bundleIdentifier!) {
            if UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            }
        }
    }
}

extension UIApplication {
    func openLink(_ link: String) {
        guard let link = URL(string: link) else { return }
        UIApplication.shared.open(link)
    }
    
    func openLink(_ link: URL?) {
        guard let link = link else { return }
        UIApplication.shared.open(link)
    }
}
