//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 24.06.2022.
//

import Foundation

extension Date {

    func convertToMonthYearFotmat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current

        return dateFormatter.string(from: self)
    }
}
