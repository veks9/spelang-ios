//
//  SpinnerView.swift
//  spelang
//
//  Created by Vedran Hernaus on 17.01.2023..
//

import UIKit

final class SpinnerView: UIView {
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.hidesWhenStopped = true
        view.color = .gray
        
        return view
    }()
    
    init(backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        addSubviews()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(activityIndicatorView)
    }
    
    private func setConstraints() {
        activityIndicatorView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(100)
        }
    }
}

// MARK: - Public functions

extension SpinnerView {
    func showSpinner() {
        activityIndicatorView.startAnimating()
        isHidden = false
    }
    
    func hideSpinner() {
        activityIndicatorView.stopAnimating()
        isHidden = true
    }
}


