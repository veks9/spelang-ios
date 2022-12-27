//
//  UITextField+.swift
//  Fansomnia
//
//  Created by Krešimir Baković on 14/12/2020.
//

import UIKit
import Combine

extension UITextField {
    func notNilOrEmpty() -> Bool {
        if let text = self.text?.trimmingCharacters(in: .whitespacesAndNewlines), text.isEmpty {
            return false
        } else {
            return true
        }
    }
}

extension UITextField {
    var textPublisher: AnyPublisher<String?, Never> {
            NotificationCenter.default.publisher(
                for: UITextField.textDidChangeNotification,
                object: self
            )
            .map { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
        }
}
