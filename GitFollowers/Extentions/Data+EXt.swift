//
//  Data+EXt.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 05/04/2025.
//

import Foundation

extension String {
    func converToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale     = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone   = .current
        
        return dateFormatter.date(from: self)
    }
}
