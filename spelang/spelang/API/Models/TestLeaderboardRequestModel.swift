//
//  TestLeaderboardRequestModel.swift
//  spelang
//
//  Created by Luka Bokarica on 16.01.2023..
//

import Foundation

extension Model {
    struct TestLeaderboardRequest: Codable, Hashable {
        let difficulty: String
        let category: String
    }
}
