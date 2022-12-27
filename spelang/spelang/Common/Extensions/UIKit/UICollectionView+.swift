//
//  UICollectionView+.swift
//  Fansomnia
//
//  Created by Azzaro Mujic on 04/08/2020.
//  Copyright © 2020 Speck. All rights reserved.
//

import UIKit

public extension UICollectionView {
    /// Register a UICollectionViewCell for reuse with the class name as the reuse identifier
    ///
    /// - Parameter _: The class to be registered
    func registerCell<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }

    /// Register a `UICollectionReusableView` for reuse with the class name as the reuse identifier
    ///
    /// - Parameter _: The class to be registered
    func registerHeader<T: UICollectionReusableView>(_: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: T.self))
    }

    /// Register a `UICollectionReusableView` for reuse with the class name as the reuse identifier
    ///
    /// - Parameter _: The class to be registered
    func registerFooter<T: UICollectionReusableView>(_: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: T.self))
    }

    /// Dequeue a reusable header with the class name as the reuse identifier
    ///
    /// - Parameter indexPath: The `indexPath` to dequeue the cell for
    /// - Returns: The dequeued header
    func dequeueHeader<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        guard let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                            withReuseIdentifier: String(describing: T.self),
                                                            for: indexPath) as? T
        else {
            fatalError("Could not dequeue header with identifier: \(String(describing: T.self))")
        }

        return header
    }

    /// Dequeue a reusable footer with the class name as the reuse identifier
    ///
    /// - Parameter indexPath: The `indexPath` to dequeue the cell for
    /// - Returns: The dequeued footer
    func dequeueFooter<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        guard let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                            withReuseIdentifier: String(describing: T.self),
                                                            for: indexPath) as? T
        else {
            fatalError("Could not dequeue footer with identifier: \(String(describing: T.self))")
        }

        return header
    }

    /// Dequeue a reusable cell with the class name as the reuse identifier
    ///
    /// - Parameter indexPath: The `indexPath` to dequeue the cell for
    /// - Returns: The dequeued cell
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T
        else {
            fatalError("Could not dequeue cell with identifier: \(String(describing: T.self))")
        }

        return cell
    }
}
