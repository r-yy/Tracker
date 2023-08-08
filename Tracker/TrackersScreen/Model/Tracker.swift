//
//  Tracker.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

struct Tracker {
    let trackerID: String
    let title: String
    let color: UIColor
    let emoji: String
    let schedule: [String]?
    var dayCounter: Int = 0
    var isPinned: Bool
    let initialCategory: String
}
