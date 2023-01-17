//
//  UserLeaderboardPositionCell.swift
//  spelang
//
//  Created by Luka Bokarica on 16.01.2023..
//

import Foundation
import UIKit

final class UserLeaderboardPositionCell: UITableViewCell {
    
    private var viewModel: UserLeaderboardPositionCellViewModel?
    
    // MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var leaderboardPositionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.set(textColor: .white, font: .systemFont(ofSize: 30, weight: .regular))
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.set(textColor: .white, font: .systemFont(ofSize: 30, weight: .regular))
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.set(textColor: .white, font: .systemFont(ofSize: 30, weight: .regular))
        
        return label
    }()
    
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        styleCell()
        addSubviews()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleCell() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        contentView.addSubview(leaderboardPositionLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(scoreLabel)
    }
    
    private func setConstraints() {
        leaderboardPositionLabel.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview()
            $0.width.equalTo(40)
        }
        
        usernameLabel.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(leaderboardPositionLabel.snp.trailing).offset(5)
            $0.trailing.equalTo(scoreLabel.snp.leading)
        }
        
        scoreLabel.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview()
        }
    }
    
    private func styleLabels(isCurrentUser: Bool) {
        leaderboardPositionLabel.set(textColor: isCurrentUser ? .appYellow : .white, font: .systemFont(ofSize: 30, weight: .semibold))
        usernameLabel.set(textColor: isCurrentUser ? .appYellow : .white, font: .systemFont(ofSize: 30, weight: .semibold))
        scoreLabel.set(textColor: isCurrentUser ? .appYellow : .white, font: .systemFont(ofSize: 30, weight: .semibold))
    }
}

// MARK: - Public methods

extension UserLeaderboardPositionCell {
    func updateUI(with viewModel: UserLeaderboardPositionCellViewModel) {
        self.viewModel = viewModel
        leaderboardPositionLabel.text = "#\(viewModel.position)"
        usernameLabel.text = viewModel.username
        scoreLabel.text = viewModel.score
        styleLabels(isCurrentUser: viewModel.isCurrentUser)
    }
}

