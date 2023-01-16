//
//  TestLeaderboardViewController.swift
//  spelang
//
//  Created by Luka Bokarica on 16.01.2023..
//

import Foundation
import UIKit
import Combine

final class TestLeaderboardViewController: UIViewController {
    
    private var viewModel: TestLeaderboardViewModeling
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Views
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Assets.darkBackground.image
        
        return imageView
    }()
    
    private lazy var leaderboardTitleContainerView: GradientView = {
        let view = GradientView(
            colors: [UIColor.gradientBlue.cgColor, UIColor.gradientGreen.cgColor],
            gradientDirection: .topBottom
        )
        view.layer.cornerRadius = 35
        
        return view
    }()
    
    private lazy var leaderboardTitleStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        // TODO: fix distribution to match design from Figma
        view.distribution = .fillProportionally
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var leaderboardTitleLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 30, weight: .bold))
        label.text = "leaderboard_title".localized()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var trophyImageView: UIImageView = {
        let view = UIImageView()
        view.image = Assets.tropyhIcon.image
        
        return view
    }()
    
    private lazy var leaderboardTableContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        
        return blurEffectView
    }()
    
    private lazy var testCategoryContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appLightBlue
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    private lazy var testCategoryLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 30, weight: .bold))
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserLeaderboardPositionCell.self, forCellReuseIdentifier: UserLeaderboardPositionCell.identity)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    
    // MARK: - Lifecycle
    
    init(viewModel: TestLeaderboardViewModeling) {
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
    
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(leaderboardTitleContainerView)
        leaderboardTitleContainerView.addSubview(leaderboardTitleStackView)
        leaderboardTitleStackView.addArrangedSubview(leaderboardTitleLabel)
        leaderboardTitleStackView.addArrangedSubview(trophyImageView)
        view.addSubview(leaderboardTableContainerView)
        leaderboardTableContainerView.addSubview(blurEffectView)
        leaderboardTableContainerView.addSubview(testCategoryContainerView)
        testCategoryContainerView.addSubview(testCategoryLabel)
        testCategoryContainerView.addSubview(tableView)
    }
    
    private func setConstraints() {
        backgroundImageView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        leaderboardTitleContainerView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(400)
            $0.height.equalTo(70)
        }
        
        leaderboardTitleStackView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        leaderboardTableContainerView.snp.remakeConstraints {
            $0.top.equalTo(leaderboardTitleContainerView.snp.bottom).offset(50)
            $0.bottom.equalToSuperview().offset(-50)
            $0.leading.trailing.equalToSuperview().inset(100)
        }
        
        blurEffectView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        testCategoryContainerView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(70)
        }
        
        testCategoryLabel.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        tableView.snp.remakeConstraints {
            $0.top.equalTo(testCategoryContainerView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func observe() {
        viewModel.updateUI
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                if value {
                    self.updateUI()
                }
            })
            .store(in: &cancellables)
    }
}

// MARK: - Public methods

extension TestLeaderboardViewController {
    func updateUI() {
        testCategoryLabel.text = viewModel.testCategoryName
        tableView.dataSource = viewModel.dataSource
    }
}
