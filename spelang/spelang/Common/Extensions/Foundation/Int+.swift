//
//  Int+.swift
//  Fansomnia
//
//  Created by Azzaro Mujic on 17/08/2020.
//  Copyright © 2020 Speck. All rights reserved.
//

import Foundation

extension Int {
    func toString() -> String {
        return String(self)
    }
    
    /// 12:04
    func getMinutesAndSeconds() -> String {
        let minutes = (self % 3600) / 60
        let seconds = (self % 3600) % 60
        let minutesString: String = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let secondsString: String = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        return "\(minutesString):\(secondsString)"
    }
}

extension Int {
    func getFirstDigit() -> Int {
        var number = self
        while number >= 10 {
            number /= 10
        }
        
        return number % 10
    }
}

extension Int {
    func numberOfDigits() -> Int {
        if abs(self) < 10 {
            return 1
        } else {
            return 1 + (self / 10).numberOfDigits()
        }
    }
}

extension Int {
    var ordinal: String {
        var suffix: String
        let ones: Int = self % 10
        let tens: Int = (self/10) % 10
        if tens == 1 {
            suffix = "th"
        } else if ones == 1 {
            suffix = "st"
        } else if ones == 2 {
            suffix = "nd"
        } else if ones == 3 {
            suffix = "rd"
        } else {
            suffix = "th"
        }
        return "\(self)\(suffix)"
    }
}
