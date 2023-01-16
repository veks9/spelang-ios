//
//  TestListViewController.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import UIKit
import SnapKit

final class TestListViewController: UIViewController {
    
    private var viewModel: TestListViewModeling
    
    // MARK: - Views
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Assets.darkBackground.image
        
        return imageView
    }()
    
    private lazy var titleContainerView: GradientView = {
        let view = GradientView(
            colors: [UIColor.gradientBlue.cgColor, UIColor.gradientGreen.cgColor],
            gradientDirection: .topBottom
        )
        view.layer.cornerRadius = 35
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 30, weight: .bold))
        label.text = "".localized()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var seeLeaderboardButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle("test_list_see_leaderboard_button_title".localized(), for: .normal)
        button.titleLabel?.set(textColor: .white, font: .systemFont(ofSize: 22, weight: .semibold))
        button.backgroundColor = .clear
        
        return button
    }()
    
    private lazy var testsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.register(TestListCategoryCell.self, forCellReuseIdentifier: TestListCategoryCell.identity)
        tableView.register(TestListSeparatorCell.self, forCellReuseIdentifier: TestListSeparatorCell.identity)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.contentInsetAdjustmentBehavior = .never
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: TestListViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        observe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func addSubviews() {
        view.addSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        view.addSubview(seeLeaderboardButton)
        view.addSubview(testsTableView)
    }
    
    private func setConstraints() {
        titleContainerView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(70)
            $0.width.equalTo(500)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        seeLeaderboardButton.snp.remakeConstraints {
            $0.top.equalTo(titleContainerView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(70)
        }
        
        testsTableView.snp.remakeConstraints {
            $0.top.equalTo(seeLeaderboardButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func observe() {
        seeLeaderboardButton.onTap { [weak self] in
            guard let self = self else { return }
            self.viewModel.navigateToLeaderBoards()
        }
    }
}

// MARK: - TestListRouterDelegate

extension TestListViewController: TestListRouterDelegate {}
