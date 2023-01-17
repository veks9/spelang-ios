//
//  TestListCategoryCell.swift
//  spelang
//
//  Created by Vedran Hernaus on 16.01.2023..
//

import Foundation
import UIKit
import SnapKit

final class TestListCategoryCell: UITableViewCell {
    
    private var viewModel: TestListCategoryCellViewModel?
    private let bottomNotch: CGFloat = UIDevice.current.bottomInset ?? 0
    
    // MARK: - Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        
        return view
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        
        return blurEffectView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 30, weight: .semibold))
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var testsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 30
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.registerCell(TestCell.self)
        view.delegate = self
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomNotch, right: 0)
        view.isScrollEnabled = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleView()
        addSubviews()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleView() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(blurEffectView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(testsCollectionView)
    }
    
    private func setConstraints() {
        containerView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        blurEffectView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.remakeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(30)
        }
        
        testsCollectionView.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(30)
        }
        testsCollectionView.setContentHuggingPriority(.required, for: .vertical)
        testsCollectionView.setContentCompressionResistancePriority(.required, for: .vertical)
    }
}

// MARK: - Public functions

extension TestListCategoryCell {
    func updateUI(viewModel: TestListCategoryCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title.capitalized
        testsCollectionView.dataSource = viewModel.dataSource
        testsCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate

extension TestListCategoryCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.cellTapped(at: indexPath)
    }
}

extension TestListCategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 240, height: 160)
    }
}
