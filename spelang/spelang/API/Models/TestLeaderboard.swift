//
//  TestLeaderboard.swift
//  spelang
//
//  Created by Vedran Hernaus on 17.01.2023..
//

import Foundation

extension Model {
    struct TestLeaderboard: Codable, Hashable {
        let leaderboards: [Test]
    }
    
    struct Test: Codable, Hashable {
        let difficulty: String
        let categories: [Category]
    }
    
    struct Category: Codable, Hashable {
        let name: String
        let rank: String?
        
        enum CodingKeys: String, CodingKey {
            case name = "category"
            case rank
        }
    }
}
