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

    func viewDidLoad()
    func closeButtonTapped()
}

final class TestLeaderboardViewModel {
    
    private let router: TestLeaderboardRouting
    private let context: TestLeaderboardContext
    private let testLeaderboardService: TestLeaderboardServicing
    
    private let updateUISubject: PassthroughSubject<TestLeaderboardModel, Never> = .init()
    private var cancellables: Set<AnyCancellable> = .init()
    
    var dataSource: TestLeaderboardDataSource = TestLeaderboardDataSource()
    
    init(
        context: TestLeaderboardContext,
        router: TestLeaderboardRouting,
        testLeaderboardService: TestLeaderboardServicing = TestLeaderboardService()
    ) {
        self.context = context
        self.router = router
        self.testLeaderboardService = testLeaderboardService
    }
}

// MARK: - TestLeaderboardViewModeling

extension TestLeaderboardViewModel: TestLeaderboardViewModeling {
    var updateUI: AnyPublisher<TestLeaderboardModel, Never> {
        updateUISubject.eraseToAnyPublisher()
    }
    
    func viewDidLoad() {
        testLeaderboardService.fetchTestLeaderboard(difficulty: "easy", categoryName: context.testCategoryName.lowercased())
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
                self.dataSource.items = UserLeaderboardPositionCellViewModel.map(from: positions)
                self.updateUISubject.send(
                    TestLeaderboardModel(
                        categoryName: self.context.testCategoryName,
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
