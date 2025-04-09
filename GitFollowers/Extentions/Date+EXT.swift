//
//  Date+EXT.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 05/04/2025.
//

import Foundation

extension Date {
   
    func convertToMonthYearFormat () -> String {
        return formatted(.dateTime.month(.wide).year())
    }
}
