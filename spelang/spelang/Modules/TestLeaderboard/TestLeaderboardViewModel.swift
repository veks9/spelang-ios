//
//  TestLeaderboardViewModel.swift
//  spelang
//
//  Created by Luka Bokarica on 16.01.2023..
//

import Foundation
import Combine

protocol TestLeaderboardViewModeling {
    var updateUI: AnyPublisher<TestLeaderboardModel, Never> { get }
    var isLoading: AnyPublisher<Bool, Never> { get }

    func viewDidLoad()
    func closeButtonTapped()
}

final class TestLeaderboardViewModel {
    
    private let router: TestLeaderboardRouting
    private let context: TestLeaderboardContext
    private let testLeaderboardService: TestLeaderboardServicing
    private let userDefaultsStorage: UserDefaultsStoring
    
    private let updateUISubject: PassthroughSubject<TestLeaderboardModel, Never> = .init()
    private let isLoadingSubject: PassthroughSubject<Bool, Never> = .init()
    private var cancellables: Set<AnyCancellable> = .init()
    
    var dataSource: TestLeaderboardDataSource = TestLeaderboardDataSource()
    
    init(
        context: TestLeaderboardContext,
        router: TestLeaderboardRouting,
        testLeaderboardService: TestLeaderboardServicing = TestLeaderboardService(),
        userDefaultsStorage: UserDefaultsStoring = UserDefaultsStorage.shared
    ) {
        self.context = context
        self.router = router
        self.testLeaderboardService = testLeaderboardService
        self.userDefaultsStorage = userDefaultsStorage
    }
}

// MARK: - TestLeaderboardViewModeling

extension TestLeaderboardViewModel: TestLeaderboardViewModeling {
    var updateUI: AnyPublisher<TestLeaderboardModel, Never> {
        updateUISubject.eraseToAnyPublisher()
    }
    
    var isLoading: AnyPublisher<Bool, Never> {
        isLoadingSubject.eraseToAnyPublisher()
    }
    
    func viewDidLoad() {
        isLoadingSubject.send(true)
        testLeaderboardService.fetchTestLeaderboard(difficulty: context.difficulty, categoryName: context.categoryName.lowercased())
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("🔴🔴🔴🔴\(error)🔴🔴🔴🔴")
                }
            }, receiveValue: { [weak self] positions in
                guard let self = self else { return }
                self.dataSource.items = UserLeaderboardPositionCellViewModel.map(
                    from: positions,
                    currentUserUsername: self.userDefaultsStorage.username
                )
                self.isLoadingSubject.send(false)
                self.updateUISubject.send(
                    TestLeaderboardModel(
                        categoryName: self.context.categoryName,
                        dataSource: self.dataSource
                    )
                )
            })
            .store(in: &cancellables)
    }
    
    func closeButtonTapped() {
        router.dismiss()
    }
}
