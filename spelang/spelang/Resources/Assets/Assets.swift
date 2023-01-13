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
    
    var image: UIImage? {
        return UIImage(named: rawValue)
    }

    var systemImage: UIImage? {
        return UIImage(systemName: rawValue)
    }
}
