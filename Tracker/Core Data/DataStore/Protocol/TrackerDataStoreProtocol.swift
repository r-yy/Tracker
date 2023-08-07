//
//  TrackerDataStore.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 22.07.2023.
//

import CoreData

protocol TrackerDataStore {
    func add(_ tracker: Tracker) throws
    func getTracker(by id: String) -> Tracker?
    func getTrackerCoreData(by id: String) -> TrackerCoreData?
    func increaseDayCounter(trackerID: String) throws
    func decreaseDayCounter(trackerID: String) throws
    func getCategoryFrom(tracker: Tracker) -> String?
}

