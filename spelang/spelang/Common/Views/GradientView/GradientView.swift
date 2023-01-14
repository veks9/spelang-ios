//
//  GradientView.swift
//  spelang
//
//  Created by Vedran Hernaus on 14.01.2023..
//

import UIKit

enum GradientDirection {
    case topBottom
    case leftRight
}

class GradientView: UIView {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    init(colors: [CGColor], gradientDirection: GradientDirection) {
        super.init(frame: .zero)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = colors
        switch gradientDirection {
        case .topBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        case .leftRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
