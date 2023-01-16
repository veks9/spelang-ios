//
//  TestCell.swift
//  spelang
//
//  Created by Vedran Hernaus on 15.01.2023..
//

import UIKit
import SnapKit

final class TestCell: UICollectionViewCell {
    private var viewModel: TestCellViewModel?
    
    // MARK: - Views
    
    private lazy var placementContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    private lazy var placementLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 20, weight: .bold))
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        
        return label
    }()
    
    private lazy var gradientContainerView: GradientView = {
        let view = GradientView(
            colors: [UIColor.gradientBlue.cgColor, UIColor.gradientGreen.cgColor],
            gradientDirection: .topBottom
        )
        view.layer.cornerRadius = 40
        
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appDarkBlue
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .titlePrimary, font: .systemFont(ofSize: 16, weight: .bold))
        label.textAlignment = .center
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(gradientContainerView)
        gradientContainerView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        contentView.addSubview(placementContainerView)
        placementContainerView.addSubview(placementLabel)
    }
    
    private func setConstraints() {
        placementContainerView.snp.remakeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(80)
        }
        
        placementLabel.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        gradientContainerView.snp.remakeConstraints {
            $0.top.equalTo(placementContainerView.snp.top).offset(10)
            $0.trailing.equalTo(placementContainerView.snp.trailing).offset(-20)
            $0.leading.bottom.equalToSuperview()
        }
        
        containerView.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(3)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

// MARK: - Public functions

extension TestCell {
    func updateUI(viewModel: TestCellViewModel) {
        self.viewModel = viewModel
        placementLabel.text = "#\(viewModel.leaderboardPosition)"
        titleLabel.text = viewModel.title
    }
}


