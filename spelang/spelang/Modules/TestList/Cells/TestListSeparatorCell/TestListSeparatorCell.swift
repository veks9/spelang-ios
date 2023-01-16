//
//  TestListSeparatorCell.swift
//  spelang
//
//  Created by Vedran Hernaus on 16.01.2023..
//

import Foundation
import UIKit
import SnapKit

final class TestListSeparatorCell: UITableViewCell {
    
    // MARK: - Views
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleView()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleView() {
        selectionStyle = .none
    }
    
    private func setConstraints() {
        snp.remakeConstraints {
            $0.height.equalTo(40)
        }
    }
}
