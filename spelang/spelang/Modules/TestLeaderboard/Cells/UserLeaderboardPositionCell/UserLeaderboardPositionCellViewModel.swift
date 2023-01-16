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
    
    init(position: Int, username: String, score: String) {
        self.position = position
        self.username = username
        self.score = score
    }
}
