//
//  TestResultDetailsView.swift
//  spelang
//
//  Created by Luka Bokarica on 15.01.2023..
//

import Foundation
import UIKit

final class TestResultDetailsView: UIView {
    
    // TODO: FIX THIS (MAKE PRIVATE)
    var viewModel: TestResultDetailsViewModel?
    
    // MARK: - Views
    
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
    
    private lazy var closeTestResultDetailsButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(Assets.closeIcon.image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 12.5, left: 12.5, bottom: 12.5, right: 12.5)
        
        return button
    }()
    
    private lazy var testResultDetailsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.set(textColor: .white, font: .systemFont(ofSize: 30, weight: .bold))
        label.text = "test_result_details_label_title".localized()
        
        return label
    }()
    
    private lazy var columnTitlesStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillEqually
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var wordColumnTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.set(textColor: .white, font: .systemFont(ofSize: 22, weight: .bold))
        label.text = "test_result_details_word_column_title".localized()
        
        return label
    }()
    
    private lazy var answerColumnTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.set(textColor: .white, font: .systemFont(ofSize: 22, weight: .bold))
        label.text = "test_result_details_answer_column_title".localized()
        
        return label
    }()
    
    private lazy var correctColumnTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.set(textColor: .white, font: .systemFont(ofSize: 22, weight: .bold))
        label.text = "test_result_details_correct_column_title".localized()
        
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.register(TestQuestionResultCell.self, forCellReuseIdentifier: TestQuestionResultCell.identity)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    private lazy var hideTestDetailsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        return button
    }()
    
    private lazy var hideTestDetailsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        
        return view
    }()
    
    private lazy var hideShowMoreImageView: UIImageView = {
        let view = UIImageView()
        view.image = Assets.rightArrowhead.image?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .white
        view.transform = view.transform.rotated(by: .pi * 1.5) // 90˚
        
        return view
    }()
    
    private lazy var hideTestDetailsLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 22, weight: .semibold))
        label.text = "test_result_hide_details_button_title".localized()
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
        observe()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(blurEffectView)
        containerView.addSubview(closeTestResultDetailsButton)
        containerView.addSubview(testResultDetailsLabel)
        
        containerView.addSubview(columnTitlesStackView)
        columnTitlesStackView.addArrangedSubview(wordColumnTitleLabel)
        columnTitlesStackView.addArrangedSubview(answerColumnTitleLabel)
        columnTitlesStackView.addArrangedSubview(correctColumnTitleLabel)
        containerView.addSubview(separatorView)
    
        containerView.addSubview(tableView)
        
        containerView.addSubview(hideTestDetailsButton)
        containerView.addSubview(hideTestDetailsContainerView)
        hideTestDetailsContainerView.addSubview(hideShowMoreImageView)
        hideTestDetailsContainerView.addSubview(hideTestDetailsLabel)
    }
    
    private func setConstraints() {
        containerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        blurEffectView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        closeTestResultDetailsButton.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.width.equalTo(45)
        }
        
        testResultDetailsLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(40)
        }
        
        columnTitlesStackView.snp.remakeConstraints {
            $0.top.equalTo(testResultDetailsLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        separatorView.snp.remakeConstraints {
            $0.top.equalTo(columnTitlesStackView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(columnTitlesStackView)
            $0.height.equalTo(2)
        }
        
        tableView.snp.remakeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(columnTitlesStackView)
            $0.bottom.equalTo(hideTestDetailsContainerView.snp.top).offset(-20)
        }
        
        hideTestDetailsContainerView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(95)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        hideShowMoreImageView.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        hideTestDetailsLabel.snp.remakeConstraints {
            $0.top.equalTo(hideShowMoreImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        hideTestDetailsButton.snp.remakeConstraints {
            $0.edges.equalTo(hideTestDetailsContainerView)
        }
    }
    
    private func observe() {
        closeTestResultDetailsButton.onTap { [weak self] in
            guard let self = self else { return }
            self.viewModel?.closeTestResultDetailsButtonTapped()
        }
        
        hideTestDetailsButton.onTap { [weak self] in
            guard let self = self else { return }
            self.viewModel?.closeTestResultDetailsButtonTapped()
        }
    }
}

// MARK: - Public methods

extension TestResultDetailsView {
    func updateUI(viewModel: TestResultDetailsViewModel) {
        self.viewModel = viewModel
        tableView.dataSource = viewModel.dataSource
    }
}

// MARK: - UITableViewDelegate

extension TestResultDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
