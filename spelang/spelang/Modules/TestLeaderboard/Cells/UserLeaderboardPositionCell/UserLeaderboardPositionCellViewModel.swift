//
//  UserLeaderboardPositionCellViewModel.swift
//  spelang
//
//  Created by Luka Bokarica on 16.01.2023..
//

import Foundation

final class UserLeaderboardPositionCellViewModel {
    let position: Int
    let username: String
    let score: String
    let isCurrentUser: Bool
    
    init(
        position: Int,
        username: String,
        score: String,
        isCurrentUser: Bool = false
    ) {
        self.position = position
        self.username = username
        self.score = score
        self.isCurrentUser = isCurrentUser
    }
    
    static func map(from models: [Model.TestLeaderboardPosition], currentUserUsername: String) -> [TestLeaderboardCellType] {
        models.enumerated().map { (index, position) in
                .leaderboardUser(
                    UserLeaderboardPositionCellViewModel(
                        position: index + 1,
                        username: position.username,
                        score: position.score.toString(),
                        isCurrentUser: position.username == currentUserUsername
                    )
                )
        }
    }
}
