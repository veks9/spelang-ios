//
//  TestLeaderboardService.swift
//  spelang
//
//  Created by Luka Bokarica on 16.01.2023..
//

import Foundation
import Combine

final class TestLeaderboardService: TestLeaderboardServicing {
    func fetchTestLeaderboard(difficulty: String, categoryName: String) -> AnyPublisher<[Model.TestLeaderboardPosition], Model.ErrorResponse> {
        return APIClient.shared.performRequest(TestLeaderboardRequest(difficulty: difficulty, categoryName: categoryName)).eraseToAnyPublisher()
    }
}
