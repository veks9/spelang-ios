//
//  TestLeaderboardDataSource.swift
//  spelang
//
//  Created by Luka Bokarica on 16.01.2023..
//

import Foundation
import UIKit

enum TestLeaderboardCellType{
    case leaderboardUser(UserLeaderboardPositionCellViewModel)
}

final class TestLeaderboardDataSource: NSObject {
    var items: [TestLeaderboardCellType] = []
}

extension TestLeaderboardDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.row] {
        case .leaderboardUser(let cellViewModel):
            let cell: UserLeaderboardPositionCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
            cell.updateUI(with: cellViewModel)
            
            return cell
        }
    }
}
