//
//  TestQuestionViewModel.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import Combine

protocol TestQuestionViewModeling {
    var updateUI: AnyPublisher<TestQuestionTopViewModel, Never> { get }
    
    func processAnswer(answer: String?)
    func skipButtonTapped()
    func viewDidLoad()
}

final class TestQuestionViewModel {

    private let router: TestQuestionRouting
    private let context: TestQuestionContext
    
    private var questions: [TestQuestion]
    private var currentIndex: Int = 0
    private let updateUISubject: PassthroughSubject<TestQuestionTopViewModel, Never> = .init()
    
    init(
        context: TestQuestionContext,
        router: TestQuestionRouting
    ) {
        self.context = context
        self.router = router
        self.questions = context.questions
    }
    
    private func nextQuestion() {
        currentIndex += 1
        updateUISubject.send(
            TestQuestionTopViewModel(
                categoryName: context.categoryName,
                word: questions[currentIndex].word
            )
        )
    }
}

// MARK: - TestQuestionViewModeling

extension TestQuestionViewModel: TestQuestionViewModeling {
    var updateUI: AnyPublisher<TestQuestionTopViewModel, Never> {
        updateUISubject.eraseToAnyPublisher()
    }
    
    func processAnswer(answer: String?) {
        if currentIndex == questions.count - 1 {
            // service send to backend
            // router Navigate to
        } else {
            questions[currentIndex].answer = answer ?? nil
            nextQuestion()
        }
    }
    
    func skipButtonTapped() {
        processAnswer(answer: nil)
    }
    
    func viewDidLoad() {
        updateUISubject.send(
            TestQuestionTopViewModel(
                categoryName: context.categoryName,
                word: questions[0].word
            )
        )
    }
}
