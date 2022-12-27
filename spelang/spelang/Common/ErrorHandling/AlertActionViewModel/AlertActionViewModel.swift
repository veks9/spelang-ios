//
//  AlertActionViewModel.swift
//  Pokemons
//
//  Created by Vedran Hernaus on 12.10.2022..
//

import Foundation

struct AlertActionViewModel {
    public let title: String
    public let action: (() -> Void)?

    public init(title: String, action: (() -> Void)?) {
        self.title = title
        self.action = action
    }
}
