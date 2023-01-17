//
//  TestListDataSource.swift
//  spelang
//
//  Created by Vedran Hernaus on 16.01.2023..
//

import UIKit

enum TestListCellType {
    case separator
    case category(TestListCategoryCellViewModel)
}

final class TestListDataSource: NSObject {
    
    let items: [TestListCellType]
    
    init(items: [TestListCellType]) {
        self.items = items
    }
}

extension TestListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.row] {
        case .separator:
            let cell: TestListSeparatorCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
            
            return cell
        case .category(let cellViewModel):
            let cell: TestListCategoryCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
            cell.updateUI(viewModel: cellViewModel)
            
            return cell
        }
    }
}
