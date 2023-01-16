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
        // TODO: fix alignment and distribution to match design from figma
        view.alignment = .center
        view.distribution = .fillEqually
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var leaderboardPositionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.set(textColor: .white, font: .systemFont(ofSize: 22, weight: .regular))
        
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.set(textColor: .white, font: .systemFont(ofSize: 22, weight: .regular))
        
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.set(textColor: .white, font: .systemFont(ofSize: 22, weight: .regular))
        
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackgroundNavyBlue
        
        return view
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
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(leaderboardPositionLabel)
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(scoreLabel)
        contentView.addSubview(separatorView)
    }
    
    private func setConstraints() {
        stackView.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        
        separatorView.snp.remakeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
}

// MARK: - Public methods

extension UserLeaderboardPositionCell {
    func updateUI(with viewModel: UserLeaderboardPositionCellViewModel) {
        self.viewModel = viewModel
        leaderboardPositionLabel.text = "#\(viewModel.position)"
        usernameLabel.text = viewModel.username
        scoreLabel.text = viewModel.score
    }
}

