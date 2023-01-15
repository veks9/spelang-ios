//
//  TestResultDetailsViewModel.swift
//  spelang
//
//  Created by Luka Bokarica on 15.01.2023..
//

import Foundation

final class TestResultDetailsViewModel {
    
    var dataSource: TestResultDetailsDataSource
    @Published var closeTestResultDetailsButtonRelay: Bool = false
    
    init(dataSource: TestResultDetailsDataSource) {
        self.dataSource = dataSource
    }
    
    func closeTestResultDetailsButtonTapped() {
        closeTestResultDetailsButtonRelay = true
    }
}
