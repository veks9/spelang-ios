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
    var context: TestResultContext { get }
    
    func backToTestListButtonTapped()
    func seeTestLeaderboardTapped()
    func viewDidLoad()
}

final class TestResultViewModel {

    private let router: TestResultRouting
    let context: TestResultContext
    
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
    
    func seeTestLeaderboardTapped() {
        router.navigateToTestLeaderboard(categoryName: context.categoryName, difficulty: context.difficulty)
    }
    
    func viewDidLoad() {
        let testResultModel = TestResultModel(
            correctAnswers: context.questions.filter { $0.isAnswerCorrect }.count,
            numberOfQuestions: context.questions.count,
            leaderboardPosition: context.rank,
            categoryName: context.categoryName
        )
        updateUISubject.send(testResultModel)
    }
}
