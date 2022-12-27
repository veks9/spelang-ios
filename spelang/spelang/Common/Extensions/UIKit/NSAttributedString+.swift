//
//  NSAttributedString+.swift
//  Pokemons
//
//  Created by Vedran Hernaus on 20.09.2022..
//

import UIKit

extension NSAttributedString {
    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }
    
    static func getAttributedString(color: UIColor, font: UIFont, title: String) -> NSAttributedString {
        let attribute = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font]
        
        return NSAttributedString(string: title, attributes: attribute)
    }
}
