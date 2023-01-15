//
//  TestQuestionTopViewModel.swift
//  spelang
//
//  Created by Vedran Hernaus on 14.01.2023..
//

import Foundation

final class TestQuestionTopViewModel {
    let categoryName: String
    let word: String
    
    init(
        categoryName: String,
        word: String
    ) {
        self.categoryName = categoryName
        self.word = word
    }
}
