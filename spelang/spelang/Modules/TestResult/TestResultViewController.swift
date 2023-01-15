//
//  TestResultViewController.swift
//  spelang
//
//  Created by Luka Bokarica on 14.01.2023..
//

import Foundation
import UIKit

final class TestResultViewController: UIViewController {
    
    private var viewModel: TestResultViewModeling
    
    // MARK: - Views
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Assets.darkBackground.image
        
        return imageView
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
    
    private lazy var containerView: UIView = {
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
        button.titleLabel?.set(textColor: .white, font: .systemFont(ofSize: 26, weight: .semibold))
        button.setTitle("test_result_show_test_details_button_title".localized(), for: .normal)
        button.titleLabel?.textAlignment = .center
        
        return button
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
    }
    
    private func setupView() {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(testCategoryContainerView)
        testCategoryContainerView.addSubview(testCategoryLabel)
        view.addSubview(containerView)
        containerView.addSubview(blurEffectView)
        containerView.addSubview(newPersonalBestLabel)
        containerView.addSubview(scoreLabel)
        containerView.addSubview(leaderboardPositionLabel)
        containerView.addSubview(showTestDetailsButton)
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
        
        containerView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(165)
            $0.height.equalTo(420)
        }
        
        blurEffectView.snp.remakeConstraints {
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
        
        showTestDetailsButton.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(95)
            $0.bottom.equalToSuperview().offset(-40)
        }
        
        backToTestListButton.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(165)
            $0.bottom.equalToSuperview().offset(-75)
            $0.height.equalTo(50)
        }
    }
    
    private func observe() {
        backToTestListButton.onTap { [weak self] in
            guard let self = self else { return }
            self.viewModel.backToTestListButtonTapped()
        }
    }
}

// MARK: - Public methods

extension TestResultViewController {
    func updateUI(with viewModel: TestResultViewModeling) {
        self.viewModel = viewModel
        // TODO: remove mocked data when connected to API
        self.testCategoryLabel.text = "Animals"
        self.scoreLabel.text = "8/10"
        self.leaderboardPositionLabel.text = "5th on leaderboard"
    }
}
