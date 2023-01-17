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
    
    private lazy var containerView: UIView = .init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleView()
        addSubviews()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleView() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
    }
    
    private func setConstraints() {
        containerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}
