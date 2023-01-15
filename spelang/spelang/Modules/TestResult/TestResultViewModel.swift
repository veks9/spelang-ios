//
//  TestResultViewModel.swift
//  spelang
//
//  Created by Luka Bokarica on 14.01.2023..
//

import Foundation

protocol TestResultViewModeling {
    func showTestDetailsButtonTapped()
    func backToTestListButtonTapped()
}

final class TestResultViewModel: TestResultViewModeling {

    private let router: TestResultRouting
    private let context: TestResultContext
    
    init(
        context: TestResultContext,
        router: TestResultRouting
    ) {
        self.context = context
        self.router = router
    }
    
    func showTestDetailsButtonTapped() {
        
    }
    
    func backToTestListButtonTapped() {
        router.navigateToTestList()
    }
}
