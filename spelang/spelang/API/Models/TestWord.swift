//
//  TestWord.swift
//  spelang
//
//  Created by Vedran Hernaus on 17.01.2023..
//

import Foundation

extension Model {
    struct TestWord: Codable, Hashable {
        let translations: [String : String]
        // TODO: - maybe change this to enum
        let difficulty: String
        let category: String
        
        enum CodingKeys: String, CodingKey {
            case translations
            case difficulty = "difficulty_level"
            case category
        }
    }
}
