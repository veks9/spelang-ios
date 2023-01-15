//
//  TestResultModel.swift
//  spelang
//
//  Created by Vedran Hernaus on 15.01.2023..
//

import Foundation

struct TestResultModel {
    let correctAnswers: Int
    let numberOfQuestions: Int
    let leaderboardPosition: Int
    let categoryName: String
    
    var scoreFormatted: String {
        "\(correctAnswers)/\(numberOfQuestions)"
    }
}
