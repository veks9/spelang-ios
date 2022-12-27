//
//  UIDevice+.swift
//  Fansomnia
//
//  Created by Krešimir Baković on 17/12/2020.
//

import Foundation
import UIKit

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let bottom = UIApplication.appWindow.safeAreaInsets.bottom
            return bottom > 0
        } else {
            return false
        }
    }

    var bottomInset: CGFloat? {
        if #available(iOS 11.0, *) {
            return UIApplication.appWindow.safeAreaInsets.bottom
        } else {
            return nil
        }
    }

    var topInset: CGFloat? {
        if #available(iOS 11.0, *) {
            return UIApplication.appWindow.safeAreaInsets.top
        } else {
            return nil
        }
    }
}
