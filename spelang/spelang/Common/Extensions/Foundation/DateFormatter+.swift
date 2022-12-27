//
//  DateFormatter+.swift
//  BBL
//
//  Created by Vedran Hernaus on 20.12.2022..
//

import Foundation

extension DateFormatter {
    static var dayMonthYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.M.yyyy"
        return formatter
    }
    
    static var fullFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
}
