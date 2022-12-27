//
//  AppDelegate.swift
//  BBL
//
//  Created by Vedran Hernaus on 16.10.2022..
//

import Foundation

extension Model {
    enum ErrorCode: String, Codable {
        case unknown = "unknown"
        case decodingError = "decodingError"

        var description: String {
            switch self {
            case .unknown:
                return "unknown_error_description".localized()
            case .decodingError:
                return "decoding_error_description".localized()
            }
        }
    }
}
