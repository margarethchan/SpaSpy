//
//  DateFormatter.swift
//  SpaSpy
//
//  Created by C4Q on 6/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

// Timestamp Generator

extension DateFormatter {
    static let dateFormatterFull: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = .long
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()
    
    static let dateFormatterShort: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()
    
    
}
