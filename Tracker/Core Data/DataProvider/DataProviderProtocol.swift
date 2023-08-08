//
//  DataProviderProtocol.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 24.07.2023.
//

import Foundation

protocol DataProviderProtocol {
    func addTracker(tracker: Tracker)
    func addTrackerCategory(category: TrackerCategory)
    func addTrackerRecord(record: TrackerRecord)
    func getCategories() -> [TrackerCategory]
    func getTracker(by id: String) -> Tracker?
    func getTrackerCoreData(by id: String) -> TrackerCoreData?
    func getTrackerRecords() -> [TrackerRecord]
    func increaseDayCounter(trackerID: String)
    func removeTrackerRecord(trackerID: String, date: Date)
    func decreaseDayCounter(trackerID: String)
    func getCategoryFrom(tracker: Tracker) -> String?
    func editTracker(trackerCategory: TrackerCategory)
    func deleteTracker(tracker: Tracker)
    func getTrackersRecord() -> [TrackerRecord]
}
