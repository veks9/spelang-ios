//
//  TestViewController.swift
//  spelang
//
//  Created by Luka Bokarica on 13.01.2023..
//

import UIKit
import MLKit

class TestViewController: UIViewController {
    
    private let viewModel: TestViewModeling

    // MARK: - Views
    
    private lazy var canvasView: CanvasView = {
        let view = CanvasView()
        
        return view
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: TestViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
        addSubviews()
        setConstraints()
        observe()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    private func styleView() {
        view.backgroundColor = .blue

    }
    
    private func addSubviews() {
        
    }
    
    private func setConstraints() {
        
    }
    
    private func observe() {
        
    }
}

extension TestViewController: StrokeManagerDelegate {
    func clearInk() {
        
    }
    
    func redraw() {
        
    }
    
    func displayMessage(message: String) {
        
    }
}
