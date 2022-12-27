//
//  AnyPublisher+.swift
//  BBL
//
//  Created by Vedran Hernaus on 23.11.2022..
//

import Foundation
import Combine

extension AnyPublisher {
    func removeHeader<T>() -> AnyPublisher<Dictionary<String, T>, Failure> {
        map { output in
            (output as? Dictionary<String, T>)?.filter { $0.key != "0" } ?? [:]
        }
        .eraseToAnyPublisher()
    }
}
