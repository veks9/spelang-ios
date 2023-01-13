//
//  LoginTextFieldView.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import UIKit
import Combine

final class LoginTextFieldView: UIView {
    
    private var viewModel: LoginTextFieldViewModel?
    
    // MARK: - Views
    
    private lazy var textField: UITextField = {
        let view = UITextField()
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.textColor = .black
        view.autocorrectionType = .no
        view.delegate = self
        view.backgroundColor = .white
        
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        styleView()
        addSubviews()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleView() {
        backgroundColor = .white
        layer.cornerRadius = 10
    }
    
    private func addSubviews() {
        addSubview(textField)
    }
    
    private func setConstraints() {
        textField.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

// MARK: - Public properties

extension LoginTextFieldView {
    var text: AnyPublisher<String?, Never> {
        textField.textPublisher
    }
    
    func updateUI(placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString.getAttributedString(
            color: .grayDark,
            font: .systemFont(ofSize: 16, weight: .semibold),
            title: placeholder
        )
    }
}

// MARK: - UITextFieldDelegate

extension LoginTextFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
