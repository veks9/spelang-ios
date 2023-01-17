//
//  Endpoint.swift
//  Pokemons
//
//  Created by Krešimir Baković on 19/11/2020.
//  Copyright © 2020 Kreso Bakovic. All rights reserved.
//

import Foundation

enum Endpoint {
    case getUser
    case createUser
    case testLeaderboard(String, String)
    
    var path: String {
        return NetworkConstants.baseURLString + _path
    }

    private var _path: String {
        switch self {
        case .getUser:
            return "/users"
        case .createUser:
            return "/users"
        case .testLeaderboard(let categoryName, let difficulty):
            return "/test/leaderboard/category/\(categoryName)/difficulty/\(difficulty)"
        }
    }
}
