//
//  TestListViewModel.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation

protocol TestListViewModeling {
    func navigateToLeaderBoards()
}

final class TestListViewModel {

    private let router: TestListRouting
        
    init(
        router: TestListRouting
    ) {
        self.router = router
    }
}

// MARK: - TestListViewModeling

extension TestListViewModel: TestListViewModeling {
    func navigateToLeaderBoards() {
        router.navigateToLeaderBoards()
    }
}
