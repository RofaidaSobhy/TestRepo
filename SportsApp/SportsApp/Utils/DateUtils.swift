//
//  DateUtils.swift
//  SportsApp
//
//  Created by Macos on 17/05/2025.
//

import Foundation

struct DateUtils {
    
    static func getFromDateOneYearAgo() -> String {
        return getFormattedDate(offsetYears: -1)
    }

    static func getToDateOneYearAhead() -> String {
        return getFormattedDate(offsetYears: 1)
    }

    private static func getFormattedDate(offsetYears: Int) -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        if let adjustedDate = calendar.date(byAdding: .year, value: offsetYears, to: currentDate) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: adjustedDate)
        }
        return ""
    }
}
