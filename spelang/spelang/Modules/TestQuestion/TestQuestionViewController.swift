//
//  TestQuestionViewController.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import UIKit
import SnapKit
import MLKit
import Combine

final class TestQuestionViewController: UIViewController {
    
    private var viewModel: TestQuestionViewModeling
    
    /** Constant defining how to render strokes. */
    private var kBrushWidth: CGFloat = 2.0
    
    /** Default language selected when demo app starts up. */
    private var defaultLanguage: String = ""
    
    /** Coordinates of the previous touch point as the user is drawing ink. */
    private var lastPoint: CGPoint?
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    /**
     * Object that takes care of the logic of saving the ink, sending ink to the recognizer after a
     * long enough pause, and storing the recognition results.
     */
    private lazy var strokeManager: StrokeManager = {
        let manager: StrokeManager = .init()
        manager.delegate = self
        
        return manager
    }()
    
    // MARK: - Views
    
    private lazy var drawnImage: UIImageView = .init()
    
    private lazy var topView: TestQuestionTopView = .init()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .appBackgroundNavyBlue
        button.tintColor = .white
        button.setTitle("canvas_clear_button_title".localized(), for: .normal)
        button.contentEdgeInsets = .init(vertical: 20, horizontal: 30)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .appRed
        button.tintColor = .white
        button.setTitle("canvas_skip_button_title".localized(), for: .normal)
        button.contentEdgeInsets = .init(vertical: 20, horizontal: 30)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        
        return button
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .appGreen
        button.tintColor = .white
        button.setTitle("canvas_done_button_title".localized(), for: .normal)
        button.contentEdgeInsets = .init(vertical: 20, horizontal: 30)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: TestQuestionViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Find the language most closely associated with the preferred language, falling back to English
        // if we can't find a match.
        let defaultLanguageIdentifier: DigitalInkRecognitionModelIdentifier =
        NSLocale.preferredLanguages.lazy.compactMap {
            try? DigitalInkRecognitionModelIdentifier.from(languageTag: $0)
        }.first ?? (try! DigitalInkRecognitionModelIdentifier.from(languageTag: "en"))
        defaultLanguage = defaultLanguageIdentifier.languageTag
        
        strokeManager.selectLanguage(languageTag: defaultLanguageIdentifier.languageTag)
        strokeManager.downloadModel()
        
        styleView()
        addSubviews()
        setConstraints()
        observe()
        
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func styleView() {
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        view.addSubview(drawnImage)
        view.addSubview(topView)
        view.addSubview(clearButton)
        view.addSubview(skipButton)
        view.addSubview(doneButton)
    }
    
    private func setConstraints() {
        topView.snp.remakeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        drawnImage.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        clearButton.snp.remakeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().offset(-60)
            $0.height.equalTo(50)
        }
        
        skipButton.snp.remakeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(60)
            $0.height.equalTo(50)
        }
        
        doneButton.snp.remakeConstraints {
            $0.centerY.equalTo(skipButton)
            $0.trailing.equalTo(skipButton.snp.leading).offset(-20)
            $0.height.equalTo(50)
        }
    }
    
    private func observe() {
        viewModel.updateUI
            .sink(receiveValue: { [weak self] topViewModel in
                guard let self = self else { return }
                self.topView.updateUI(viewModel: topViewModel)
            })
            .store(in: &cancellables)
        
        clearButton.onTap { [weak self] in
            guard let self = self else { return }
            self.clearInk()
        }
        
        doneButton.onTap { [weak self] in
            guard let self = self else { return }
            self.strokeManager.recognizeInk()
        }
        
        skipButton.onTap { [weak self] in
            guard let self = self else { return }
            self.clearInk()
            self.viewModel.skipButtonTapped()
        }
    }
    
    /** Handle start of stroke: Draw the point, and pass it along to the `StrokeManager`. */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        // Since this is a new stroke, make last point the same as the current point.
        lastPoint = touch.location(in: drawnImage)
        guard let lastPoint = lastPoint else { return }
        let time = touch.timestamp
        drawLineSegment(touch: touch)
        strokeManager.startStrokeAtPoint(point: lastPoint, t: time)
    }
    
    /** Handle continuing a stroke: Draw the line segment, and pass along to the `StrokeManager`. */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
              let lastPoint = lastPoint
        else { return }
        drawLineSegment(touch: touch)
        strokeManager.continueStrokeAtPoint(point: lastPoint, t: touch.timestamp)
    }
    
    /** Handle end of stroke: Draw the line segment, and pass along to the `StrokeManager`. */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
              let lastPoint = lastPoint
        else { return }
        drawLineSegment(touch: touch)
        strokeManager.endStrokeAtPoint(point: lastPoint, t: touch.timestamp)
    }
    
    /**
     * Draws a line segment from `self.lastPoint` to the current touch point given in the argument
     * to the temporary ink canvas.
     */
    func drawLineSegment(touch: UITouch) {
        let currentPoint = touch.location(in: drawnImage)
        
        UIGraphicsBeginImageContext(drawnImage.frame.size)
        drawnImage.image?.draw(
            in: CGRect(
                x: 0, y: 0, width: drawnImage.frame.size.width, height: drawnImage.frame.size.height))
        let ctx: CGContext? = UIGraphicsGetCurrentContext()
        guard let ctx = ctx,
              let lastPoint = lastPoint
        else { return }
        ctx.move(to: lastPoint)
        ctx.addLine(to: currentPoint)
        ctx.setLineCap(CGLineCap.round)
        ctx.setLineWidth(kBrushWidth)
        // Unrecognized strokes are drawn in blue.
        ctx.setStrokeColor(red: 0, green: 0, blue: 1, alpha: 1)
        ctx.setBlendMode(CGBlendMode.normal)
        ctx.strokePath()
        ctx.flush()
        drawnImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.lastPoint = currentPoint
    }
    
    /** Given an `Ink`, returned the bounding box of the ink. */
    func getInkRect(ink: Ink) -> CGRect {
        var rect = CGRect.null
        if ink.strokes.count == 0 {
            return rect
        }
        for stroke in ink.strokes {
            for point in stroke.points {
                rect = rect.union(CGRect(x: Double(point.x), y: Double(point.y), width: 0, height: 0))
            }
        }
        // Make the minimum size 10x10 pixels.
        rect = rect.union(
            CGRect(
                x: rect.midX - 5,
                y: rect.midY - 5,
                width: 10,
                height: 10))
        return rect
    }
}

// MARK: - TestListRouterDelegate

extension TestQuestionViewController: TestQuestionRouterDelegate {}

// MARK: - StrokeManagerDelegate

extension TestQuestionViewController: StrokeManagerDelegate {
    /**
     * Clear temporary ink in progress. This is invoked by the `StrokeManager` when the temporary ink is
     * sent to the recognizer.
     */
    func clearInk() {
        drawnImage.image = nil
        strokeManager.clear()
    }

    func displayMessage(message: String) {}
    
    func didRecognizeCanvasWord(_ canvasWord: String?) {
        viewModel.processAnswer(answer: canvasWord)
    }
}
