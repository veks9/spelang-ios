//
//  TestResult.swift
//  spelang
//
//  Created by Vedran Hernaus on 17.01.2023..
//

import Foundation

extension Model {
    struct TestResult: Codable, Hashable {
        let category: String
        let difficulty: String
        let username: String
        let score: Int
        let rank: Int
    }
}
