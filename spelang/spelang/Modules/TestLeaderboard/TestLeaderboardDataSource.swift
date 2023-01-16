//
//  TestLeaderboardDataSource.swift
//  spelang
//
//  Created by Luka Bokarica on 16.01.2023..
//

import Foundation
import UIKit

final class TestLeaderboardDataSource: NSObject {
    
    var items: [UserLeaderboardPositionCellViewModel] = [UserLeaderboardPositionCellViewModel(position: 1, username: "Fićo", score: "18/20"),
                                                         UserLeaderboardPositionCellViewModel(position: 2, username: "Boki", score: "11/20"),
                                                         UserLeaderboardPositionCellViewModel(position: 3, username: "Veki", score: "3/20"),
                                                         UserLeaderboardPositionCellViewModel(position: 4, username: "Fićo", score: "18/20"),
                                                         UserLeaderboardPositionCellViewModel(position: 5, username: "Boki", score: "11/20"),
                                                         UserLeaderboardPositionCellViewModel(position: 6, username: "Veki", score: "3/20"),
                                                         UserLeaderboardPositionCellViewModel(position: 7, username: "Fićo", score: "18/20"),
                                                         UserLeaderboardPositionCellViewModel(position: 8, username: "Boki", score: "11/20"),
                                                         UserLeaderboardPositionCellViewModel(position: 9, username: "Veki", score: "3/20"),
                                                         UserLeaderboardPositionCellViewModel(position: 10, username: "Fićo", score: "18/20"),
                                                         UserLeaderboardPositionCellViewModel(position: 11, username: "Boki", score: "11/20"),
                                                         UserLeaderboardPositionCellViewModel(position: 12, username: "Veki", score: "3/20")]
    
    override init() {
        super.init()
    }
    
    private func fillUpItems(with data: [UserLeaderboardPositionCellViewModel]) {
        
    }
}

extension TestLeaderboardDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserLeaderboardPositionCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
        cell.updateUI(with: items[indexPath.row])
        
        return cell
    }
}
