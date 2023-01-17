//
//  LeaderboardListContext.swift
//  spelang
//
//  Created by Luka Bokarica on 17.01.2023..
//

import Foundation

struct LeaderboardListContext {
    let leaderboard: Model.TestLeaderboard
    
    init(leaderboard: Model.TestLeaderboard) {
        self.leaderboard = leaderboard
    }
}
