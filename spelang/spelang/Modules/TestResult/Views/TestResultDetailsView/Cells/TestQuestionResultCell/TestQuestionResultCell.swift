//
//  TestQuestionResultCell.swift
//  spelang
//
//  Created by Luka Bokarica on 15.01.2023..
//

import Foundation
import UIKit

final class TestQuestionResultCell: UITableViewCell {
    private var viewModel: TestQuestionResultCellViewModel?
    
    // MARK: - Views
    
    
    // MARK: - Lifecycle
    
    
}

// MARK: - Public methods

extension TestQuestionResultCell {
    func updateUI(with viewModel: TestQuestionResultCellViewModel) {
        self.viewModel = viewModel
    }
}
