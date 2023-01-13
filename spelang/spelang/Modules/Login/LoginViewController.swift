//
//  LoginViewController.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import UIKit
import Combine

final class LoginViewController: UIViewController {
    
    private var viewModel: LoginViewModeling
    private var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Views
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Assets.mainBackground.image
        
        return imageView
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 100, weight: .bold))
        label.textAlignment = .center
        label.text = "login_title".localized()
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.set(textColor: .white, font: .systemFont(ofSize: 20, weight: .bold))
        label.textAlignment = .center
        label.text = "login_subtitle".localized()
        
        return label
    }()
    
    private lazy var usernameTextFieldView: LoginTextFieldView = {
        let view = LoginTextFieldView()
        view.updateUI(placeholder: "login_first_text_field_placeholder".localized())
        
        return view
    }()
    
    private lazy var pinTextFieldView: LoginTextFieldView = {
        let view = LoginTextFieldView()
        view.updateUI(placeholder: "login_second_text_field_placeholder".localized())
        
        return view
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("login_submit_button_title".localized(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
    
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: LoginViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        observe()
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(containerView)
        containerView.addSubview(blurEffectView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(usernameTextFieldView)
        containerView.addSubview(pinTextFieldView)
        containerView.addSubview(submitButton)
    }
    
    private func setConstraints() {
        backgroundImageView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(505)
        }
        
        blurEffectView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        subtitleLabel.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        usernameTextFieldView.snp.remakeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(45)
            $0.leading.trailing.equalToSuperview().inset(83)
        }
        
        pinTextFieldView.snp.remakeConstraints {
            $0.top.equalTo(usernameTextFieldView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(83)
        }
        
        submitButton.snp.remakeConstraints {
            $0.top.equalTo(pinTextFieldView.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(83)
            $0.bottom.equalToSuperview().offset(-25)
            $0.height.equalTo(50)
        }
    }
    
    private func observe() {
        submitButton.onTap { [weak self] in
            guard let self = self else { return }
            self.viewModel.submitButtonTapped()
        }
        
        usernameTextFieldView.text
            .sink(receiveValue: { [weak self] username in
                guard let self = self else { return }
                self.viewModel.usernameTextChanged(username)
            })
            .store(in: &cancellables)
        
        pinTextFieldView.text
            .sink(receiveValue: { [weak self] pin in
                guard let self = self else { return }
                self.viewModel.pinTextChanged(pin)
            })
            .store(in: &cancellables)
    }
}
