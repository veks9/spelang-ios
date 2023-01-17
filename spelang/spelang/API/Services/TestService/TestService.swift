//
//  TestService.swift
//  spelang
//
//  Created by Vedran Hernaus on 17.01.2023..
//

import Foundation
import Combine

final class TestService: TestServicing {
    func getTestBy(categoryName: String, difficulty: String) -> AnyPublisher<[Model.TestWord], Model.ErrorResponse> {
        APIClient.shared.performRequest(GetTestByCategoryAndDifficulty(categoryName: categoryName, difficulty: difficulty)).eraseToAnyPublisher()
    }
    
    func getAllTests(username: String) -> AnyPublisher<Model.TestLeaderboard, Model.ErrorResponse> {
        APIClient.shared.performRequest(GetAllTests(username: username)).eraseToAnyPublisher()
    }
}
