//
//  TestLeaderboardPosition.swift
//  spelang
//
//  Created by Luka Bokarica on 16.01.2023..
//

import Foundation

extension Model {
    struct TestLeaderboardPosition: Codable, Hashable {
        let username: String
        let score: Float
        let category: String
        let difficulty: String
    }
}
