//
//  TestResultViewModel.swift
//  spelang
//
//  Created by Luka Bokarica on 14.01.2023..
//

import Foundation
import Combine

protocol TestResultViewModeling {
    var updateUI: AnyPublisher<TestResultModel, Never> { get }
    
    func backToTestListButtonTapped()
    func viewDidLoad()
}

final class TestResultViewModel {

    private let router: TestResultRouting
    private let context: TestResultContext
    
    private let updateUISubject: PassthroughSubject<TestResultModel, Never> = .init()
    
    init(
        context: TestResultContext,
        router: TestResultRouting
    ) {
        self.context = context
        self.router = router
    }
}

// MARK: - TestResultViewModeling

extension TestResultViewModel: TestResultViewModeling {
    var updateUI: AnyPublisher<TestResultModel, Never> {
        updateUISubject.eraseToAnyPublisher()
    }
    
    func backToTestListButtonTapped() {
        router.navigateToTestList()
    }
    
    func viewDidLoad() {
        let testResultModel = TestResultModel(
            correctAnswers: context.questions.filter { $0.isAnswerCorrect }.count,
            numberOfQuestions: context.questions.count,
            // TODO: - get this from API
            leaderboardPosition: 5,
            categoryName: context.categoryName
        )
        updateUISubject.send(testResultModel)
    }
}
