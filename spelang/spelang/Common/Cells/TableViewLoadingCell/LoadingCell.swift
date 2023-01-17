//
//  LoadingCell.swift
//  spelang
//
//  Created by Vedran Hernaus on 17.01.2023..
//

import UIKit

final class LoadingCell: UITableViewCell {
    
    // MARK: - Views
    
    private lazy var spinnerView: SpinnerView = {
        let view = SpinnerView(backgroundColor: .backgroundPrimary)
        view.showSpinner()
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(spinnerView)
    }
    
    private func setConstraints() {
        spinnerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
