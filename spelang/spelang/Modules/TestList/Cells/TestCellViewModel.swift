//
//  TestCellViewModel.swift
//  spelang
//
//  Created by Vedran Hernaus on 15.01.2023..
//

import Foundation

final class TestCellViewModel {
    let title: String
    let leaderboardPosition: Int?
    
    init(
        title: String,
        leaderboardPosition: Int?
    ) {
        self.title = title
        self.leaderboardPosition = leaderboardPosition
    }
}
