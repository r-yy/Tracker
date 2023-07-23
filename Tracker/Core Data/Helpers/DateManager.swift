//
//  DateManager.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 24.07.2023.
//

import Foundation

final class DateManager {
    static let shared = DateManager()

    private let dateFormatter = DateFormatter()
    private let calendar = Calendar.current
    
    func getDateOnly(date: Date) -> Date {
        let dateComponents = calendar.dateComponents(
            [.year, .month, .day], from: date
        )
        guard let dateOnly = calendar.date(from: dateComponents) else {
            return Date()
        }
        return dateOnly
    }

    func getDayInWeek(date: Date) -> String {
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }
}
