//
//  UIControl+.swift
//  Pokemons
//
//  Created by Krešimir Baković on 04.06.2022..
//

import UIKit

extension UIControl {
    func onTap(handler: @escaping () -> Void) {
        addAction(.init(handler: { _ in
            handler()
        }), for: .touchUpInside)
    }

    func onTouchDown(handler: @escaping () -> Void) {
        addAction(.init(handler: { _ in
            handler()
        }), for: [.touchDown, .touchCancel])
    }

    func onTouchCanceledOrEnded(handler: @escaping () -> Void) {
        addAction(.init(handler: { _ in
            handler()
        }), for: [.touchUpInside, .touchCancel, .touchDragExit])
    }
}
