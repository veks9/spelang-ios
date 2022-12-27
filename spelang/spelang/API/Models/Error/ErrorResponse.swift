//
//  AppDelegate.swift
//  BBL
//
//  Created by Vedran Hernaus on 16.10.2022..
//

import Foundation

extension Model {
    struct ErrorResponse: Codable, Error {
        let message: String?
        let time: Int?
        let code: ErrorCode?

        init(
            message: String? = nil,
            time: Int? = nil,
            code: ErrorCode?
        ) {
            self.message = message
            self.time = time
            self.code = code
        }

        init(
            from error: Error
        ) {
            message = error.localizedDescription
            time = nil
            code = .init(rawValue: error.localizedDescription)
        }

        var description: String {
            code?.description ?? "unknown_error_description".localized()
        }
    }
}
