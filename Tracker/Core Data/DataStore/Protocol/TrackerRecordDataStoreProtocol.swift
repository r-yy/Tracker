//
//  TrackerRecordDataStore.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 22.07.2023.
//

import CoreData

protocol TrackerRecordDataStore {
    func add(_ trackerRecord: TrackerRecord) throws
    func removeTrackerRecord(trackerID: String, date: Date) throws
}
