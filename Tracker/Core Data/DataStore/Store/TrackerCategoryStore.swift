//
//  TrackerCategoryStore.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 21.07.2023.
//

import CoreData

final class TrackerCategoryStore {
    private let dataProvider: DataProviderProtocol
    private let context: NSManagedObjectContext

    init(dataProvider: DataProvider) throws {
        self.dataProvider = dataProvider
        self.context = dataProvider.context
    }

    private func performSync<R>(
        _ action: (NSManagedObjectContext) -> Result<R, Error>
    ) throws -> R {
        let context = self.context
        var result: Result<R, Error>!
        context.performAndWait { result = action(context) }
        return try result.get()
    }
}

extension TrackerCategoryStore: TrackerCategoryDataStore {
    func add(_ trackerCategory: TrackerCategory) throws {
        try performSync { context in
            Result {
                let trackerCategoryData = TrackerCategoryCoreData(
                    context: context
                )
                trackerCategoryData.id = UUID()
                trackerCategoryData.title = trackerCategory.title

                let trackerSet = trackerCategory.trackers.compactMap { tracker -> TrackerCoreData? in
                    if let existingTrackerData = dataProvider.getTrackerCoreData(by: tracker.trackerID) {
                        existingTrackerData.category = trackerCategoryData
                        return existingTrackerData
                    } else {
                        let trackerData = TrackerCoreData(context: context)
                        trackerData.trackerID = tracker.trackerID
                        trackerData.title = tracker.title
                        trackerData.color = tracker.color.hexString
                        trackerData.emoji = tracker.emoji
                        trackerData.schedule = tracker.schedule?.joined(separator: ",")
                        trackerData.dayCounter = Int64(tracker.dayCounter)
                        trackerData.category = trackerCategoryData
                        return trackerData
                    }
                }
                trackerCategoryData.trackers = NSSet(array: trackerSet)
                try context.save()
            }
        }
    }
}

