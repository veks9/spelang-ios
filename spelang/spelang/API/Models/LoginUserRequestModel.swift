//
//  LoginUserRequestModel.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation

extension Model {
    struct LoginUserRequest: Codable, Hashable {
        let username: String
        let pin: String
    }
}
