//
//  TestLeaderboardService.swift
//  spelang
//
//  Created by Luka Bokarica on 16.01.2023..
//

import Foundation
import Combine

protocol TestLeaderboardServicing {
    func fetchTestLeaderboard(difficulty: String, category: String) -> AnyPublisher<[Model.TestLeaderboardPosition], Model.ErrorResponse>
}
