//
//  DateUtils.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 13/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation

extension String {
    func toDate(usingFormatter formatter: DateFormatter) -> Date? {
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self)
    }
}

extension DateFormatter {
    static var twitterTimestampFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MMM d HH:mm:ss Z yyyy"
        return dateFormatter
    }
}

extension Date {
    var dayMonthYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.string(from: self)
        return date
    }
}
