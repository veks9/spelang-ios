//
//  AlertViewModel.swift
//  Pokemons
//
//  Created by Vedran Hernaus on 10.10.2022..
//

import Foundation

struct AlertViewModel {
    public let title: String?
    public let message: String?
    public let cancelAction: AlertActionViewModel?
    public let confirmAction: AlertActionViewModel

    public init(
        title: String?,
        message: String?,
        cancelAction: AlertActionViewModel? = nil,
        confirmAction: AlertActionViewModel
    ) {
        self.title = title
        self.message = message
        self.cancelAction = cancelAction
        self.confirmAction = confirmAction
    }
}
