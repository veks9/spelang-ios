//
//  UIColor+.swift
//  Fansomnia
//
//  Created by Krešimir Baković on 02/11/2020.
//

import UIKit

extension UIColor {
    
    /// light: #EFF4F6,  dark: #EFF4F6
    static var backgroundPrimary: UIColor {
        UIColor(light: UIColor(rgb: 0xEFF4F6), dark: UIColor(rgb: 0xEFF4F6))
    }
    
    /// light: #121212,  dark: #121212
    static var backgroundSecondary: UIColor {
        UIColor(light: UIColor(rgb: 0x121212), dark: UIColor(rgb: 0x121212))
    }
    
    /// #121212
    static var appBlack: UIColor = UIColor(rgb: 0x121212)
    
    /// light: #121212,  dark: #121212
    static var titlePrimary: UIColor {
        UIColor(light: UIColor(rgb: 0x121212), dark: UIColor(rgb: 0x121212))
    }
    
    /// light: #EFF4F6,  dark: #EFF4F6
    static var titleSecondary: UIColor {
        UIColor(light: UIColor(rgb: 0xEFF4F6), dark: UIColor(rgb: 0xEFF4F6))
    }
    
    /// light: #303594,  dark: #303594
    static var appPrimary: UIColor {
        UIColor(light: UIColor(rgb: 0x303594), dark: UIColor(rgb: 0x303594))
    }
    
    /// #c8cdcd a: 0.8
    static let shadowColor = UIColor(rgb: 0xc8cdcd).withAlphaComponent(0.8)
    
    /// light: #313131,  dark: #313131
    static var grayDark: UIColor {
        UIColor(light: UIColor(rgb: 0x313131), dark: UIColor(rgb: 0x313131))
    }
    
    /// light: #C4CEDF,  dark: #C4CEDF
    static var grayMedium: UIColor {
        UIColor(light: UIColor(rgb: 0xC4CEDF), dark: UIColor(rgb: 0xC4CEDF))
    }
    
    /// #000000 a: 0.8
    static let gradientColor = UIColor(rgb: 0x000000).withAlphaComponent(0.8)
    
    /// #13B31D
    static let appGreen = UIColor(rgb: 0x13B31D)
    
    /// #A31616
    static let appRed = UIColor(rgb: 0xA31616)
    
    /// #2B3745
    static let appBackgroundNavyBlue = UIColor(rgb: 0x2B3745)
    
    /// #0053B4
    static let gradientBlue = UIColor(rgb: 0x0053B4)
    
    /// #23E1D6
    static let gradientGreen = UIColor(rgb: 0x23E1D6)
    
    /// #168CBF
    static let appLightBlue = UIColor(rgb: 0x168CBF)

    /// #161D24
    static let appDarkBlue = UIColor(rgb: 0x161D24)
    
    /// #5F666C
    static let appGray = UIColor(rgb: 0x5F666C)
    
    /// #FFC905
    static let appYellow = UIColor(rgb: 0xFFC905)
}

// MARK: - Light/Dark mode support

extension UIColor {
    convenience init(light: UIColor, dark: UIColor) {
        self.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                return light
            case .dark:
                return dark
            @unknown default:
                return light
            }
        }
    }
}

extension UIColor {
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: 1.0
        )
    }
}
