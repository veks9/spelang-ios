//
//  TestQuestionTopView.swift
//  spelang
//
//  Created by Vedran Hernaus on 14.01.2023..
//

import Foundation
import UIKit
import SnapKit

final class TestQuestionTopView: UIView {
    
    private var viewModel: TestQuestionTopViewModel?
    
    // MARK: - Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackgroundNavyBlue
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        return view
    }()
    
    private lazy var wordContainerView: GradientView = {
        let view = GradientView(
            colors: [UIColor.gradientBlue.cgColor, UIColor.gradientGreen.cgColor],
            gradientDirection: .topBottom
        )
        view.layer.cornerRadius = 35
        
        return view
    }()
    
    private lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 30, weight: .bold))
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var questionNumberLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 35, weight: .bold))
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var categoryContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackgroundNavyBlue
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        return view
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 30, weight: .bold))
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        
        return label
    }()
    
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
        containerView.addSubview(wordContainerView)
        wordContainerView.addSubview(wordLabel)
        containerView.addSubview(questionNumberLabel)
        addSubview(categoryContainerView)
        categoryContainerView.addSubview(categoryLabel)
    }
    
    private func setConstraints() {
        containerView.snp.remakeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(110)
        }
        
        wordContainerView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(400)
            $0.height.equalTo(70)
        }
        
        wordLabel.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        questionNumberLabel.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(wordContainerView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-43)
        }
        
        categoryContainerView.snp.remakeConstraints {
            $0.top.equalTo(containerView.snp.bottom)
            $0.leading.bottom.equalToSuperview()
            $0.width.equalTo(285)
        }
        
        categoryLabel.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    private func observe() {
    }
}

// MARK: - Public methods

extension TestQuestionTopView {
    func updateUI(viewModel: TestQuestionTopViewModel) {
        self.viewModel = viewModel
        wordLabel.text = viewModel.word
        categoryLabel.text = viewModel.categoryName
        questionNumberLabel.text = viewModel.currentQuestionNumberFormatted
    }
}
