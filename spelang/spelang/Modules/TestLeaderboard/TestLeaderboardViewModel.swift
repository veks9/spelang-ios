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

final class TestLeaderboardViewModel: TestLeaderboardViewModeling {
    
    var dataSource: TestLeaderboardDataSource
    var testCategoryName: String
    var updateUI: AnyPublisher<Bool, Never> {
        updateUISubject.eraseToAnyPublisher()
    }

    private let router: TestLeaderboardRouting
    private let context: TestLeaderboardContext
    
    private let updateUISubject: PassthroughSubject<Bool, Never> = .init()
    
    init(
        context: TestLeaderboardContext,
        router: TestLeaderboardRouting,
        dataSource: TestLeaderboardDataSource
    ) {
        self.context = context
        self.router = router
        self.dataSource = dataSource
        self.testCategoryName = context.testCategoryName
    }
    
    func viewDidLoad() {
        updateUISubject.send(true)
    }
}
