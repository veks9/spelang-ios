//
//  TestQuestionResultCell.swift
//  spelang
//
//  Created by Luka Bokarica on 15.01.2023..
//

import Foundation
import UIKit

final class TestQuestionResultCell: UITableViewCell {
    private var viewModel: TestQuestionResultCellViewModel?
    
    // MARK: - Views
    
    private lazy var columnTitlesStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillEqually
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.set(textColor: .white, font: .systemFont(ofSize: 22, weight: .regular))
        
        return label
    }()
    
    private lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.set(textColor: .white, font: .systemFont(ofSize: 22, weight: .regular))
        
        return label
    }()
    
    private lazy var correctLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.set(textColor: .white, font: .systemFont(ofSize: 22, weight: .regular))
        
        return label
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
        contentView.addSubview(columnTitlesStackView)
        columnTitlesStackView.addArrangedSubview(wordLabel)
        columnTitlesStackView.addArrangedSubview(answerLabel)
        columnTitlesStackView.addArrangedSubview(correctLabel)
    }
    
    private func setConstraints() {
        columnTitlesStackView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Public methods

extension TestQuestionResultCell {
    func updateUI(with viewModel: TestQuestionResultCellViewModel) {
        self.viewModel = viewModel
        wordLabel.text = viewModel.word
        answerLabel.text = viewModel.answer ?? "SKIPPED"
        let color: UIColor = viewModel.isAnswerCorrect ? .green : .red
        answerLabel.set(textColor: color, font: .systemFont(ofSize: 22, weight: .regular))
        correctLabel.text = viewModel.correct
    }
}
