//
//  TestListCategoryCellViewModel.swift
//  spelang
//
//  Created by Vedran Hernaus on 16.01.2023..
//

import Foundation
import Combine

final class TestListCategoryCellViewModel {
    let title: String
    let dataSource: TestsDataSource
    
    private let testCellTappedSubject: PassthroughSubject<TestModel, Never> = .init()
    
    var testCellTapped: AnyPublisher<TestModel, Never> {
        testCellTappedSubject.eraseToAnyPublisher()
    }
    
    init(
        title: String,
        dataSource: TestsDataSource
    ) {
        self.title = title
        self.dataSource = dataSource
    }
    
    func cellTapped(at indexPath: IndexPath) {
        switch dataSource.items[indexPath.row] {
        case .test(let cellViewModel):
            testCellTappedSubject.send(TestModel(categoryName: cellViewModel.title, difficulty: title))
        }
    }
    
    static func map(from tests: [Model.Test], isLeaderboard: Bool) -> [TestListCellType] {
        tests.map { test in
                .category(
                    TestListCategoryCellViewModel(
                        title: test.difficulty,
                        dataSource: TestsDataSource(
                            items: TestCellViewModel.map(
                                from: test.categories,
                                isLeaderboard: isLeaderboard
                            )
                        )
                    )
                )
        }
    }
}
