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
    
    private lazy var tableViewSpinnerView: SpinnerView = .init(backgroundColor: .clear)
    
    private lazy var categoryContainerSpinnerView: SpinnerView = .init(backgroundColor: .clear)
    
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
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(Assets.closeIcon.image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 12.5, left: 12.5, bottom: 12.5, right: 12.5)
        
        return button
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
        view.addSubview(dismissButton)
        view.addSubview(leaderboardTitleContainerView)
        leaderboardTitleContainerView.addSubview(leaderboardTitleStackView)
        leaderboardTitleStackView.addArrangedSubview(leaderboardTitleLabel)
        leaderboardTitleStackView.addArrangedSubview(trophyImageView)
        view.addSubview(leaderboardTableContainerView)
        leaderboardTableContainerView.addSubview(blurEffectView)
        leaderboardTableContainerView.addSubview(testCategoryContainerView)
        testCategoryContainerView.addSubview(testCategoryLabel)
        testCategoryContainerView.addSubview(categoryContainerSpinnerView)
        leaderboardTableContainerView.addSubview(tableView)
        leaderboardTableContainerView.addSubview(tableViewSpinnerView)
    }
    
    private func setConstraints() {
        backgroundImageView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dismissButton.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.width.equalTo(45)
        }
        
        leaderboardTitleContainerView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(400)
            $0.height.equalTo(70)
        }
        
        categoryContainerSpinnerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
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
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        tableViewSpinnerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func observe() {
        viewModel.isLoading
            .sink(receiveValue: { [weak self] isLoading in
                guard let self = self else { return }
                if isLoading {
                    self.categoryContainerSpinnerView.showSpinner()
                    self.tableViewSpinnerView.showSpinner()
                } else {
                    self.categoryContainerSpinnerView.hideSpinner()
                    self.tableViewSpinnerView.hideSpinner()
                }
            })
            .store(in: &cancellables)
        
        viewModel.updateUI
            .sink(receiveValue: { [weak self] model in
                guard let self = self else { return }
                self.testCategoryLabel.text = model.categoryName.capitalized
                self.tableView.dataSource = model.dataSource
                self.tableView.reloadData()
            })
            .store(in: &cancellables)
        
        dismissButton.onTap { [weak self] in
            guard let self = self else { return }
            self.viewModel.closeButtonTapped()
        }
    }
}
