//
//  TestCellViewModel.swift
//  spelang
//
//  Created by Vedran Hernaus on 15.01.2023..
//

import Foundation

final class TestCellViewModel {
    let title: String
    let leaderboardPosition: String?
    
    init(
        title: String,
        leaderboardPosition: String?
    ) {
        self.title = title
        self.leaderboardPosition = leaderboardPosition
    }
    
    static func map(from categories: [Model.Category], isLeaderboard: Bool) -> [TestsCellType] {
        categories.map { category in
                .test(
                    TestCellViewModel(
                        title: category.name,
                        leaderboardPosition: isLeaderboard ? category.rank : nil
                    )
                )
        }
    }
}
