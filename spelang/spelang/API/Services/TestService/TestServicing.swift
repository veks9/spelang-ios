//
//  TestServicing.swift
//  spelang
//
//  Created by Vedran Hernaus on 17.01.2023..
//

import Foundation
import Combine

protocol TestServicing {
    func getTestBy(categoryName: String, difficulty: String) -> AnyPublisher<[Model.TestWord], Model.ErrorResponse>
    func getAllTests(username: String)  -> AnyPublisher<Model.TestLeaderboards, Model.ErrorResponse>
    func createTest(model: Model.CreateTestBody) -> AnyPublisher<Model.TestResult, Model.ErrorResponse>
}
