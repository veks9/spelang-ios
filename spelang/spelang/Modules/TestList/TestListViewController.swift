//
//  TestListViewController.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import UIKit
import SnapKit
import Combine

final class TestListViewController: UIViewController {
    
    private var viewModel: TestListViewModeling
    private var cancellables: Set<AnyCancellable> = .init()
    private var dataSource: TestListDataSource?
    
    // MARK: - Views
    
    private lazy var tableViewSpinnerView: SpinnerView = .init(backgroundColor: .clear)
    
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
        label.text = "test_list_title".localized()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var logoutLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 20, weight: .bold))
        label.text = "logout_title".localized()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var logoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Assets.logoutIcon.image
        
        return imageView
    }()
    
    private lazy var logoutContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        
        return view
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        
        return button
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
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        
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
        viewModel.viewDidLoad()
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
        view.addSubview(backgroundImageView)
        view.addSubview(titleContainerView)
        view.addSubview(logoutContainerView)
        logoutContainerView.addSubview(logoutLabel)
        logoutContainerView.addSubview(logoutImageView)
        view.addSubview(logoutButton)
        titleContainerView.addSubview(titleLabel)
        view.addSubview(seeLeaderboardButton)
        view.addSubview(testsTableView)
        view.addSubview(tableViewSpinnerView)
    }
    
    private func setConstraints() {
        backgroundImageView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleContainerView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(70)
            $0.width.equalTo(500)
        }
        
        logoutContainerView.snp.remakeConstraints {
            $0.centerY.equalTo(titleContainerView)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        logoutLabel.snp.remakeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.trailing.equalTo(logoutImageView.snp.leading)
        }
        
        logoutImageView.snp.remakeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
        }
        
        logoutButton.snp.remakeConstraints {
            $0.edges.equalTo(logoutContainerView)
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
        
        tableViewSpinnerView.snp.remakeConstraints {
            $0.top.equalTo(seeLeaderboardButton.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func observe() {
        viewModel.isLoading
            .sink(receiveValue: { [weak self] isLoading in
                guard let self = self else { return }
                if isLoading {
                    self.tableViewSpinnerView.showSpinner()
                } else {
                    self.tableViewSpinnerView.hideSpinner()
                }
            })
            .store(in: &cancellables)
        
        viewModel.updateUI
            .sink(receiveValue: { [weak self] dataSource in
                guard let self = self else { return }
                self.dataSource = dataSource
                self.testsTableView.dataSource = dataSource
                self.testsTableView.reloadData()
            })
            .store(in: &cancellables)
        
        seeLeaderboardButton.onTap { [weak self] in
            guard let self = self else { return }
            self.viewModel.seeLeaderboardButtonTapped()
        }
        
        logoutButton.onTap { [weak self] in
            guard let self = self else { return }
            self.viewModel.logoutButtonTapped()
        }
    }
}

// MARK: - UITableViewDelegate

extension TestListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let dataSource = dataSource else { return 0 }
        switch dataSource.items[indexPath.row] {
        case .category(let cellViewModel):
            let numberOfItems = CGFloat(cellViewModel.dataSource.items.count)
            let numberOfCellsInRow = CGFloat(floor((UIScreen.width - 30) / CGFloat(240)))
            return (CGFloat(ceil(numberOfItems / numberOfCellsInRow)) * (160 + 30)) + 120
        case .separator:
            return 40
        }
    }
}
