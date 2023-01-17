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
    private let updateUISubject: PassthroughSubject<TestListDataSource, Never> = .init()
    
    var dataSource = TestListDataSource()
    
    init(
        router: TestListRouting
    ) {
        self.router = router
    }
}

// MARK: - TestListViewModeling

extension TestListViewModel: TestListViewModeling {
    var updateUI: AnyPublisher<TestListDataSource, Never> {
        updateUISubject.eraseToAnyPublisher()
    }
    
    func viewDidLoad() {
        dataSource.items = [
            .category(
                TestListCategoryCellViewModel(
                    title: "Easy",
                    dataSource: TestsDataSource(
                        items: [
                            .test(
                                TestCellViewModel(
                                    title: "Animals",
                                    leaderboardPosition: 2
                                )
                            ),
                            .test(
                                TestCellViewModel(
                                    title: "Furniture",
                                    leaderboardPosition: 3
                                )
                            ),
                            .test(
                                TestCellViewModel(
                                    title: "Cars",
                                    leaderboardPosition: 1
                                )
                            ),
                            .test(
                                TestCellViewModel(
                                    title: "Colors",
                                    leaderboardPosition: 100
                                )
                            ),
                            .test(
                                TestCellViewModel(
                                    title: "Animals",
                                    leaderboardPosition: 2
                                )
                            ),
                            .test(
                                TestCellViewModel(
                                    title: "Furniture",
                                    leaderboardPosition: 3
                                )
                            ),
                            .test(
                                TestCellViewModel(
                                    title: "Cars",
                                    leaderboardPosition: 1
                                )
                            ),
                            .test(
                                TestCellViewModel(
                                    title: "Colors",
                                    leaderboardPosition: 100
                                )
                            )
                        ]
                    )
                )
            ),
            .separator,
            .category(
                TestListCategoryCellViewModel(
                    title: "Medium",
                    dataSource: TestsDataSource(
                        items: [
                            .test(
                                TestCellViewModel(
                                    title: "Animals",
                                    leaderboardPosition: 2
                                )
                            ),
                            .test(
                                TestCellViewModel(
                                    title: "Furniture",
                                    leaderboardPosition: 3
                                )
                            ),
                            .test(
                                TestCellViewModel(
                                    title: "Cars",
                                    leaderboardPosition: 1
                                )
                            ),
                            .test(
                                TestCellViewModel(
                                    title: "Colors",
                                    leaderboardPosition: 100
                                )
                            )
                        ]
                    )
                )
            ),
            .separator,
            .category(
                TestListCategoryCellViewModel(
                    title: "Hard",
                    dataSource: TestsDataSource(
                        items: [
                            .test(
                                TestCellViewModel(
                                    title: "Animals",
                                    leaderboardPosition: 2
                                )
                            ),
                            .test(
                                TestCellViewModel(
                                    title: "Furniture",
                                    leaderboardPosition: 3
                                )
                            ),
                            .test(
                                TestCellViewModel(
                                    title: "Cars",
                                    leaderboardPosition: 1
                                )
                            ),
                            .test(
                                TestCellViewModel(
                                    title: "Colors",
                                    leaderboardPosition: 100
                                )
                            )
                        ]
                    )
                )
            ),
        ]
        updateUISubject.send(dataSource)
    }
    
    func seeLeaderboardButtonTapped() {
        router.navigateToLeaderBoards()
    }
    
    func testTapped(categoryName: String, difficulty: String) {
        print("🟡🟡🟡🟡🟡🟡🟡🟡")
    }
}
