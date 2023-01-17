//
//  TestBody.swift
//  spelang
//
//  Created by Vedran Hernaus on 17.01.2023..
//

import Foundation

extension Model {
    struct CreateTestBody: Codable, Hashable {
        let category: String
        let difficulty: String
        let username: String
        let score: Int
    }
}
