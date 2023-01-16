//
//  TestsDataSource.swift
//  spelang
//
//  Created by Vedran Hernaus on 16.01.2023..
//

import UIKit

enum TestsCellType {
    case test(TestCellViewModel)
}

final class TestsDataSource: NSObject {
    
    var items: [TestsCellType] = []
}

extension TestsDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch items[indexPath.row] {
        case .test(let cellViewModel):
            let cell: TestCell = collectionView.dequeueCell(for: indexPath)
            cell.updateUI(viewModel: cellViewModel)
            
            return cell
        }
    }
}
