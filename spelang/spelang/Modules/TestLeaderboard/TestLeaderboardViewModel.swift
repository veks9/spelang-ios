//
//  TestLeaderboardViewModel.swift
//  spelang
//
//  Created by Luka Bokarica on 16.01.2023..
//

import Foundation
import Combine

protocol TestLeaderboardViewModeling {
    var dataSource: TestLeaderboardDataSource { get set }
    var testCategoryName: String { get set }
    var updateUI: AnyPublisher<Bool, Never> { get }

    func viewDidLoad()
}

final class TestLeaderboardViewModel {
    var dataSource: TestLeaderboardDataSource
    var testCategoryName: String
    
    private let router: TestLeaderboardRouting
    private let context: TestLeaderboardContext
    private let testLeaderboardService: TestLeaderboardServicing
    
    private let updateUISubject: PassthroughSubject<Bool, Never> = .init()
    private var cancellables: Set<AnyCancellable> = .init()
    
    init(
        context: TestLeaderboardContext,
        router: TestLeaderboardRouting,
        testLeaderboardService: TestLeaderboardServicing = TestLeaderboardService(),
        dataSource: TestLeaderboardDataSource
    ) {
        self.context = context
        self.router = router
        self.dataSource = dataSource
        self.testCategoryName = context.testCategoryName
        self.testLeaderboardService = testLeaderboardService
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
                print("🟢🟢🟢🟢\(positions)🟢🟢🟢🟢")
            })
            .store(in: &cancellables)
        updateUISubject.send(true)
    }
}

// MARK: - TestLeaderboardViewModeling

extension TestLeaderboardViewModel: TestLeaderboardViewModeling {
    var updateUI: AnyPublisher<Bool, Never> {
        updateUISubject.eraseToAnyPublisher()
    }
    
}
