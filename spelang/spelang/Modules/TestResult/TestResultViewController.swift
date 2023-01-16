//
//  TestResultViewController.swift
//  spelang
//
//  Created by Luka Bokarica on 14.01.2023..
//

import Foundation
import UIKit
import Combine

final class TestResultViewController: UIViewController {
    
    private var viewModel: TestResultViewModeling
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Views
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Assets.darkBackground.image
        
        return imageView
    }()
    
    private lazy var testResultDetailsView: TestResultDetailsView = {
        let view = TestResultDetailsView()
        view.isHidden = true
        
        return view
    }()
    
    private lazy var seeLeaderboardButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle("test_result_see_leaderboard_button_title".localized(), for: .normal)
        button.titleLabel?.set(textColor: .white, font: .systemFont(ofSize: 22, weight: .semibold))
        button.backgroundColor = .clear
        
        return button
    }()
    
    
    
    private lazy var testCategoryContainerView: GradientView = {
        let view = GradientView(
            colors: [UIColor.gradientBlue.cgColor, UIColor.gradientGreen.cgColor],
            gradientDirection: .topBottom
        )
        view.layer.cornerRadius = 35
        
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
    
    private lazy var testResultContainerView: UIView = {
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
    
    private lazy var testResultContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var newPersonalBestLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 22, weight: .semibold))
        label.textAlignment = .center
        label.text = "test_result_new_personal_best_title".localized()
        
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 60, weight: .bold))
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var leaderboardPositionLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 26, weight: .semibold))
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var showTestDetailsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        return button
    }()
    
    private lazy var showTestDetailsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        
        return view
    }()
    
    private lazy var showTestDetailsLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 22, weight: .semibold))
        label.text = "test_result_show_test_details_button_title".localized()
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var showMoreImageView: UIImageView = {
        let view = UIImageView()
        view.image = Assets.rightArrowhead.image?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .white
        view.transform = view.transform.rotated(by: .pi / 2) // 90˚
        
        return view
    }()
    
    private lazy var backToTestListButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("test_result_button_title".localized(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
    
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: TestResultViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setConstraints()
        observe()
        viewModel.viewDidLoad()
        subscribeToCellViewModels()
    }
    
    private func setupView() {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(testResultDetailsView)
        view.addSubview(testCategoryContainerView)
        testCategoryContainerView.addSubview(testCategoryLabel)
        view.addSubview(seeLeaderboardButton)
        view.addSubview(testResultContainerView)
        testResultContainerView.addSubview(blurEffectView)
        testResultContainerView.addSubview(testResultContentView)
        testResultContentView.addSubview(newPersonalBestLabel)
        testResultContentView.addSubview(scoreLabel)
        testResultContentView.addSubview(leaderboardPositionLabel)
        testResultContentView.addSubview(showTestDetailsContainerView)
        testResultContentView.addSubview(showTestDetailsButton)
        showTestDetailsContainerView.addSubview(showTestDetailsLabel)
        showTestDetailsContainerView.addSubview(showMoreImageView)
        view.addSubview(backToTestListButton)
    }
    
    private func setConstraints() {
        backgroundImageView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        testCategoryContainerView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(400)
            $0.height.equalTo(70)
        }
        
        testCategoryLabel.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        seeLeaderboardButton.snp.remakeConstraints {
            $0.top.equalTo(testCategoryContainerView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(45)
        }
        
        testResultDetailsView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(100)
            $0.top.equalTo(seeLeaderboardButton.snp.bottom).offset(50)
            $0.bottom.equalTo(backToTestListButton.snp.top).offset(-50)
        }
        
        testResultContainerView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(165)
            $0.height.equalTo(420)
        }
        
        blurEffectView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        testResultContentView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        newPersonalBestLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(75)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        scoreLabel.snp.remakeConstraints {
            $0.top.equalTo(newPersonalBestLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(150)
        }
        
        scoreLabel.snp.remakeConstraints {
            $0.top.equalTo(newPersonalBestLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(120)
        }
        
        leaderboardPositionLabel.snp.remakeConstraints {
            $0.top.equalTo(scoreLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(95)
        }
        
        showTestDetailsContainerView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(95)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        showTestDetailsLabel.snp.remakeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        showMoreImageView.snp.remakeConstraints {
            $0.top.equalTo(showTestDetailsLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        showTestDetailsButton.snp.remakeConstraints {
            $0.edges.equalTo(showTestDetailsContainerView)
        }
        
        backToTestListButton.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(165)
            $0.bottom.equalToSuperview().offset(-75)
            $0.height.equalTo(50)
        }
    }
    
    private func remakeConstraintsToShowTestResultDetailsView() {
        testResultContainerView.snp.remakeConstraints {
            $0.edges.equalTo(testResultDetailsView)
        }
    }
    
    private func observe() {
        viewModel.updateUI
            .sink(receiveValue: { [weak self] model in
                guard let self = self else { return }
                self.updateUI(with: model)
            })
            .store(in: &cancellables)
        
        seeLeaderboardButton.onTap { [weak self] in
            guard let self = self else { return }
            self.viewModel.seeTestLeaderboardTapped()
        }
        
        backToTestListButton.onTap { [weak self] in
            guard let self = self else { return }
            self.viewModel.backToTestListButtonTapped()
        }
        
        showTestDetailsButton.onTap { [weak self] in
            guard let self = self else { return }
            self.animateShowTestResultDetails()
        }
    }
    
    private func updateUI(with model: TestResultModel) {
        testCategoryLabel.text = model.categoryName
        scoreLabel.text = model.scoreFormatted
        leaderboardPositionLabel.text = "\(model.leaderboardPosition.ordinal) on leaderboard"
        let context = viewModel.context
        testResultDetailsView.updateUI(viewModel: TestResultDetailsViewModel(dataSource: TestResultDetailsDataSource(from: context)))
    }
    
    private func animateShowTestResultDetails() {
        remakeConstraintsToShowTestResultDetailsView()
        testResultContentView.isHidden = true
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.3) {
                self.testResultContainerView.isHidden = true
                self.testResultDetailsView.isHidden = false
            }
        }
    }
}

// MARK: - Public methods

extension TestResultViewController {
    func subscribeToCellViewModels() {
        testResultDetailsView.viewModel?.$closeTestResultDetailsButtonRelay
            .sink { [weak self] value in
                guard let self = self else { return }
                switch value {
                case true:
                    self.testResultContainerView.isHidden = false
                    self.setConstraints()
                    self.testResultDetailsView.isHidden = true
                    UIView.animate(withDuration: 0.3) {
                        self.view.layoutIfNeeded()
                    } completion: { [weak self] _ in
                        guard let self = self else { return }
                        UIView.animate(withDuration: 0.3) {
                            self.testResultContentView.isHidden = false
                        }
                    }
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
}
