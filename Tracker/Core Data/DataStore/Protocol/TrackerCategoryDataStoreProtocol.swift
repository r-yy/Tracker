//
//  TrackerCategoryDataStore.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 22.07.2023.
//

import CoreData

protocol TrackerCategoryDataStore {
    func add(_ trackerCategory: TrackerCategory) throws
}
