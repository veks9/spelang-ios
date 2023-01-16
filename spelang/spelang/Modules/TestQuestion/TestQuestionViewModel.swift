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
    var questionNumberText: AnyPublisher<String, Never> { get }
    
    func processAnswer(answer: String?)
    func skipButtonTapped()
    func viewDidLoad()
}

final class TestQuestionViewModel {

    private let router: TestQuestionRouting
    private let context: TestQuestionContext
    
    private var questions: [TestQuestion]
    private let currentIndexSubject: CurrentValueSubject<Int, Never> = .init(0)
    private let updateUISubject: PassthroughSubject<TestQuestionTopViewModel, Never> = .init()
    private let testQuestionTopViewModel: TestQuestionTopViewModel
    
    private var currentIndexValue: Int {
        currentIndexSubject.value
    }
    
    init(
        context: TestQuestionContext,
        router: TestQuestionRouting
    ) {
        self.context = context
        self.router = router
        self.questions = context.questions
        self.testQuestionTopViewModel = TestQuestionTopViewModel(
            categoryName: context.categoryName,
            word: questions[0].word,
            numberOfQuestions: questions.count,
            currentQuestionIndex: 0
        )
    }
    
    private func nextQuestion() {
        currentIndexSubject.send(currentIndexValue + 1)
        testQuestionTopViewModel.currentQuestionIndex = currentIndexValue
        testQuestionTopViewModel.word = questions[currentIndexValue].word
        updateUISubject.send(testQuestionTopViewModel)
    }
}

// MARK: - TestQuestionViewModeling

extension TestQuestionViewModel: TestQuestionViewModeling {
    var updateUI: AnyPublisher<TestQuestionTopViewModel, Never> {
        updateUISubject.eraseToAnyPublisher()
    }
    
    var questionNumberText: AnyPublisher<String, Never> {
        currentIndexSubject.eraseToAnyPublisher()
            .map { [questions] currentIndex in
                "\(currentIndex + 1)/\(questions.count)"
            }
            .eraseToAnyPublisher()
    }
    
    func processAnswer(answer: String?) {
        questions[currentIndexValue].answer = answer ?? nil
        if currentIndexValue == questions.count - 1 {
            // service send to backend
            // router Navigate to
            router.navigateToTestResult(questions: questions, categoryName: context.categoryName)
        } else {
            nextQuestion()
        }
    }
    
    func skipButtonTapped() {
        processAnswer(answer: nil)
    }
    
    func viewDidLoad() {
        updateUISubject.send(testQuestionTopViewModel)
    }
}
