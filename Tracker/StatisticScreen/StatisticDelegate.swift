//
//  StatisticDelegate.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 09.08.2023.
//

import Foundation

protocol StatisticDelegate: AnyObject {
    func updateTrackersCompletedRecord(count: Int)
}
