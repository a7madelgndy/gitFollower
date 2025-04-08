//
//  Date+EXT.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 05/04/2025.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat () -> String {
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "MMM yyyy"
        return dateFromatter.string(from: self)
    }
}
