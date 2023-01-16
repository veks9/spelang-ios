//
//  TestQuestionTopViewModel.swift
//  spelang
//
//  Created by Vedran Hernaus on 14.01.2023..
//

import Foundation

final class TestQuestionTopViewModel {
    let categoryName: String
    var word: String
    let numberOfQuestions: Int
    var currentQuestionIndex: Int
    
    init(
        categoryName: String,
        word: String,
        numberOfQuestions: Int,
        currentQuestionIndex: Int
    ) {
        self.categoryName = categoryName
        self.word = word
        self.numberOfQuestions = numberOfQuestions
        self.currentQuestionIndex = currentQuestionIndex
    }
    
    var currentQuestionNumberFormatted: String {
        "\(currentQuestionIndex + 1)/\(numberOfQuestions)"
    }
}
