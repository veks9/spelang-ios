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
    private let testService: TestServicing
    private let userDefaultsStorage: UserDefaultsStoring
    
    private var cancellables: Set<AnyCancellable> = .init()
    private var questions: [TestQuestion] = []
    private let currentIndexSubject: CurrentValueSubject<Int, Never> = .init(0)
    private let updateUISubject: PassthroughSubject<TestQuestionTopViewModel, Never> = .init()
    private var testQuestionTopViewModel: TestQuestionTopViewModel?
    
    private var currentIndexValue: Int {
        currentIndexSubject.value
    }
    
    init(
        context: TestQuestionContext,
        router: TestQuestionRouting,
        testService: TestServicing = TestService(),
        userDefaultsStorage: UserDefaultsStoring = UserDefaultsStorage.shared
    ) {
        self.context = context
        self.router = router
        self.testService = testService
        self.userDefaultsStorage = userDefaultsStorage
    }
    
    private func nextQuestion() {
        guard let testQuestionTopViewModel = testQuestionTopViewModel else { return }
        currentIndexSubject.send(currentIndexValue + 1)
        testQuestionTopViewModel.currentQuestionIndex = currentIndexValue
        testQuestionTopViewModel.word = questions[currentIndexValue].word
        updateUISubject.send(testQuestionTopViewModel)
    }
    
    private func fillQuestions(from models: [Model.TestWord]) {
        questions = models.map { word in
            TestQuestion(
                word: word.translations["hr"] ?? "",
                translation: word.translations["en"] ?? ""
            )
        }
    }
    
    private func createTest() {
        testService.createTest(
            model: Model.CreateTestBody(
                category: context.categoryName,
                difficulty: context.difficulty,
                username: userDefaultsStorage.username,
                score: questions.filter { $0.isAnswerCorrect }.count
            )
        )
        .sink(receiveCompletion: { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("🔴🔴🔴🔴\(error)🔴🔴🔴🔴")
            }
        }, receiveValue: { [weak self] result in
            guard let self = self else { return }
            self.router.navigateToTestResult(questions: self.questions, categoryName: result.category, rank: result.rank)
        })
        .store(in: &cancellables)
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
            createTest()
        } else {
            nextQuestion()
        }
    }
    
    func skipButtonTapped() {
        processAnswer(answer: nil)
    }
    
    func viewDidLoad() {
        testService.getTestBy(categoryName: context.categoryName, difficulty: context.difficulty)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("🔴🔴🔴🔴\(error)🔴🔴🔴🔴")
                }
            }, receiveValue: { [weak self] words in
                guard let self = self else { return }
                self.fillQuestions(from: words)
                let testQuestionTopViewModel = TestQuestionTopViewModel(
                    categoryName: self.context.categoryName,
                    word: self.questions[0].word,
                    numberOfQuestions: self.questions.count,
                    currentQuestionIndex: 0
                )
                self.testQuestionTopViewModel = testQuestionTopViewModel
                self.updateUISubject.send(testQuestionTopViewModel)
            })
            .store(in: &cancellables)
    }
}
