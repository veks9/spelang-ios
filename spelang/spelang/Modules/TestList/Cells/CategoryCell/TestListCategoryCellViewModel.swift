//
//  TestListCategoryCellViewModel.swift
//  spelang
//
//  Created by Vedran Hernaus on 16.01.2023..
//

import Foundation

final class TestListCategoryCellViewModel {
    let title: String
    let dataSource: TestsDataSource
    
    init(
        title: String,
        dataSource: TestsDataSource
    ) {
        self.title = title
        self.dataSource = dataSource
    }
}
