//
//  Assets.swift
//  BBL
//
//  Created by Vedran Hernaus on 16.10.2022..
//

import Foundation

import UIKit

enum Assets: String {

    case mainBackground
    case darkBackground
    case rightArrowhead = "right_arrowhead"
    case closeIcon = "close_icon"
    
    var image: UIImage? {
        return UIImage(named: rawValue)
    }

    var systemImage: UIImage? {
        return UIImage(systemName: rawValue)
    }
}
