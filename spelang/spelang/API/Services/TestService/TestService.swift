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
        APIClient.shared.performRequest(GetTestByCategoryAndDifficultyRequest(categoryName: categoryName, difficulty: difficulty)).eraseToAnyPublisher()
    }
    
    func getAllTests(username: String) -> AnyPublisher<Model.TestLeaderboards, Model.ErrorResponse> {
        APIClient.shared.performRequest(GetAllTestsRequest(username: username)).eraseToAnyPublisher()
    }
    
    func createTest(model: Model.CreateTestBody) -> AnyPublisher<Model.TestResult, Model.ErrorResponse> {
        APIClient.shared.performRequest(CreateTestRequest(bodyModel: model)).eraseToAnyPublisher()
    }
}
