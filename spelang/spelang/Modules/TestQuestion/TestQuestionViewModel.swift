//
//  TestQuestionViewModel.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation

protocol TestQuestionViewModeling {
    func skipButtonTapped()
}

final class TestQuestionViewModel: TestQuestionViewModeling {

    private let router: TestQuestionRouting
    private let context: TestQuestionContext
    
    init(
        context: TestQuestionContext,
        router: TestQuestionRouting
    ) {
        self.context = context
        self.router = router
    }
    
    func skipButtonTapped() {
        router.navigateToTestResult()
    }
}
