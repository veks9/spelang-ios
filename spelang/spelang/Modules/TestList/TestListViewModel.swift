//
//  TestListViewModel.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import Combine

protocol TestListViewModeling {
    var updateUI: AnyPublisher<TestListDataSource, Never> { get }
    
    func viewDidLoad()
    func seeLeaderboardButtonTapped()
    func testTapped(categoryName: String, difficulty: String)
}

final class TestListViewModel {

    private let router: TestListRouting
    private let testService: TestServicing
    private let userDefaultsStorage: UserDefaultsStoring
    
    private var cancellables: Set<AnyCancellable> = .init()
    private let updateUISubject: PassthroughSubject<TestListDataSource, Never> = .init()
    
    var dataSource = TestListDataSource()
    var leaderboardsContext: Model.TestLeaderboards?
    
    init(
        router: TestListRouting,
        testService: TestServicing = TestService(),
        userDefaultsStorage: UserDefaultsStoring = UserDefaultsStorage.shared
    ) {
        self.router = router
        self.testService = testService
        self.userDefaultsStorage = userDefaultsStorage
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
                        self.testTapped(categoryName: testModel.categoryName, difficulty: testModel.difficulty)
                    })
                    .store(in: &cancellables)
            }
        }
    }
}

// MARK: - TestListViewModeling

extension TestListViewModel: TestListViewModeling {
    var updateUI: AnyPublisher<TestListDataSource, Never> {
        updateUISubject.eraseToAnyPublisher()
    }
    
    func viewDidLoad() {
        testService.getAllTests(username: userDefaultsStorage.username)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("🔴🔴🔴🔴\(error)🔴🔴🔴🔴")
                }
            }, receiveValue: { [weak self] model in
                guard let self = self else { return }
                self.leaderboardsContext = model
                self.dataSource.items = TestListCategoryCellViewModel.map(
                    from: model.leaderboards,
                    isLeaderboard: false
                )
                self.observeCells()
                self.updateUISubject.send(self.dataSource)
            })
            .store(in: &cancellables)
    }
    
    func seeLeaderboardButtonTapped() {
        guard let leaderboardsContext = leaderboardsContext else { return }
        router.navigateToLeaderBoards(with: leaderboardsContext)
    }
    
    func testTapped(categoryName: String, difficulty: String) {
        router.navigateToTestQuestion(categoryName: categoryName, difficulty: difficulty)
    }
}
