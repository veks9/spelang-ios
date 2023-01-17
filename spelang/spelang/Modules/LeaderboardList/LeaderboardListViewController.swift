//
//  LeaderboardListViewController.swift
//  spelang
//
//  Created by Luka Bokarica on 17.01.2023..
//

import UIKit
import SnapKit
import Combine

final class LeaderboardListViewController: UIViewController {
    
    private var viewModel: LeaderboardListViewModeling
    private var cancellables: Set<AnyCancellable> = .init()
    private var dataSource: TestListDataSource?
    
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
        label.text = "leaderboards_list_title".localized()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var leaderboardsTableView: UITableView = {
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
    
    init(viewModel: LeaderboardListViewModeling) {
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
        styleView()
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        view.addSubview(leaderboardsTableView)
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
        
        titleLabel.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        leaderboardsTableView.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(90)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func observe() {
        viewModel.updateUI
            .sink(receiveValue: { [weak self] dataSource in
                guard let self = self else { return }
                self.dataSource = dataSource
                self.leaderboardsTableView.dataSource = dataSource
                self.leaderboardsTableView.reloadData()
            })
            .store(in: &cancellables)
    }
    
    private func styleView() {
        self.navigationController?.navigationBar.tintColor = .white;
    }
}

// MARK: - UITableViewDelegate

extension LeaderboardListViewController: UITableViewDelegate {
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
