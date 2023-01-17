//
//  LeaderboardListViewModel.swift
//  spelang
//
//  Created by Luka Bokarica on 17.01.2023..
//

import Foundation
import Combine

protocol LeaderboardListViewModeling {
    var updateUI: AnyPublisher<TestListDataSource, Never> { get }
    
    func viewDidLoad()
    func leaderboardTapped(categoryName: String, difficulty: String)
}

final class LeaderboardListViewModel {
    
    private let router: LeaderboardListRouting
    private let testService: TestServicing
    private let userDefaultsStorage: UserDefaultsStoring
    private let context: LeaderboardListContext
    
    private var cancellables: Set<AnyCancellable> = .init()
    private let updateUISubject: PassthroughSubject<TestListDataSource, Never> = .init()
    
    var dataSource = TestListDataSource()
    
    init(
        router: LeaderboardListRouting,
        testService: TestServicing = TestService(),
        userDefaultsStorage: UserDefaultsStoring = UserDefaultsStorage.shared,
        context: LeaderboardListContext
    ) {
        self.router = router
        self.testService = testService
        self.userDefaultsStorage = userDefaultsStorage
        self.context = context
    }
    
    private func observeCells() {
        dataSource.items.forEach { cellType in
            switch cellType {
            case .separator:
                break
            case .category(let cellViewModel):
                cellViewModel.testCellTapped
                    .sink(receiveValue: { [weak self] testModel in
                        guard let self = self else { return }
                        self.leaderboardTapped(categoryName: testModel.categoryName, difficulty: testModel.difficulty)
                    })
                    .store(in: &cancellables)
            }
        }
    }
}

// MARK: - TestListViewModeling

extension LeaderboardListViewModel: LeaderboardListViewModeling {
    var updateUI: AnyPublisher<TestListDataSource, Never> {
        updateUISubject.eraseToAnyPublisher()
    }
    
    func viewDidLoad() {
        self.dataSource.items = TestListCategoryCellViewModel.map(
            from: context.leaderboard.leaderboards,
            isLeaderboard: true
        )
        self.observeCells()
        self.updateUISubject.send(self.dataSource)
    }
    
    func leaderboardTapped(categoryName: String, difficulty: String) {
        router.navigateToTestLeaderboard(for: categoryName)
    }
}
