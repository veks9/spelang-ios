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
    
    private lazy var showTestDetailsButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.set(textColor: .white, font: .systemFont(ofSize: 26, weight: .semibold))
        button.setTitle("test_result_show_test_details_button_title", for: .normal)
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("test_result_button_title".localized(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.tintColor = .white
        button.backgroundColor = .black
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
        
        addSubviews()
        setConstraints()
        observe()
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(containerView)
        containerView.addSubview(blurEffectView)
        containerView.addSubview(newPersonalBestLabel)
        containerView.addSubview(scoreLabel)
        containerView.addSubview(showTestDetailsButton)
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
    }
    
    private func observe() {
    }
}
