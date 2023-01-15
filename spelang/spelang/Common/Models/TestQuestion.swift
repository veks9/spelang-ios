//
//  TestQuestion.swift
//  spelang
//
//  Created by Vedran Hernaus on 15.01.2023..
//

import Foundation

struct TestQuestion {
    let word: String
    let translation: String
    var answer: String?
    
    var isAnswerCorrect: Bool {
        guard let answer = answer else { return false }
        return translation.lowercased() == answer.lowercased()
    }
}
