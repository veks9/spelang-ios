//
//  TestQuestionResultCellViewModel.swift
//  spelang
//
//  Created by Luka Bokarica on 15.01.2023..
//

import Foundation

final class TestQuestionResultCellViewModel {
    let word: String
    let answer: String?
    let correct: String
    let isAnswerCorrect: Bool
    
    init(word: String, answer: String?, correct: String, isAnswerCorrect: Bool) {
        self.word = word
        self.answer = answer
        self.correct = correct
        self.isAnswerCorrect = isAnswerCorrect
    }
}
