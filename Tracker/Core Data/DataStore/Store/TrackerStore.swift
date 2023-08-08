//
//  TrackerStore.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 21.07.2023.
//

import CoreData
import UIKit

final class TrackerStore {
    private let context: NSManagedObjectContext

    init(dataProvider: DataProvider) throws {
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

extension TrackerStore: TrackerDataStore {
    func add(_ tracker: Tracker) throws {
        try performSync { context in
            Result {
                let trackerData = TrackerCoreData(context: context)
                trackerData.trackerID = tracker.trackerID
                trackerData.title = tracker.title
                trackerData.color = tracker.color.hexString
                trackerData.emoji = tracker.emoji
                trackerData.schedule = tracker.schedule?.joined(separator: ",")
                trackerData.dayCounter = Int64(tracker.dayCounter)
                trackerData.isPinned = tracker.isPinned
                trackerData.initialCategory = tracker.initialCategory
                try context.save()
            }
        }
    }

    func getTracker(by id: String) -> Tracker? {
        var fetchedTracker: Tracker?
        context.performAndWait {
            let fetchRequest = NSFetchRequest<TrackerCoreData>(
                entityName: "TrackerCoreData"
            )
            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(
                format: "%K == %@", #keyPath(TrackerCoreData.trackerID), id
            )

            do {
                let result = try context.fetch(fetchRequest)
                guard let trackerData = result.first else { return }

                fetchedTracker = Tracker(
                    trackerID: trackerData.trackerID ?? "",
                    title: trackerData.title ?? "",
                    color: UIColor(hex: trackerData.color ?? ""),
                    emoji: trackerData.emoji ?? "",
                    schedule: trackerData.schedule?.components(separatedBy: ","),
                    dayCounter: Int(trackerData.dayCounter),
                    isPinned: trackerData.isPinned,
                    initialCategory: trackerData.initialCategory ?? ""
                )
            } catch {
                print("Failed to fetch Tracker with id: \(id), error: \(error)")
            }
        }
        return fetchedTracker
    }

    func getTrackerCoreData(by id: String) -> TrackerCoreData? {
        var fetchedTracker: TrackerCoreData?
        context.performAndWait {
            let fetchRequest = NSFetchRequest<TrackerCoreData>(
                entityName: "TrackerCoreData"
            )
            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(
                format: "%K == %@", #keyPath(TrackerCoreData.trackerID), id
            )

            do {
                let result = try context.fetch(fetchRequest)
                guard let trackerData = result.first else { return }
                fetchedTracker = trackerData
            } catch {
                print("Failed to fetch Tracker with id: \(id), error: \(error)")
            }
        }
        return fetchedTracker
    }

    func increaseDayCounter(trackerID: String) throws {
        let request = NSFetchRequest<TrackerCoreData>(
            entityName: "TrackerCoreData"
        )
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(
            format: "%K == %@", #keyPath(TrackerCoreData.trackerID), trackerID
        )
        guard let result = try? context.fetch(request),
              let tracker = result.first else {
            print("Tracker not found")
            return
        }

        try performSync { context in
            Result {
                tracker.dayCounter += 1
                try context.save()
            }
        }
    }

    func decreaseDayCounter(trackerID: String) throws {
        let request = NSFetchRequest<TrackerCoreData>(
            entityName: "TrackerCoreData"
        )
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(
            format: "%K == %@", #keyPath(TrackerCoreData.trackerID), trackerID
        )
        guard let result = try? context.fetch(request),
              let tracker = result.first else {
            print("Tracker not found")
            return
        }

        try performSync { context in
            Result {
                tracker.dayCounter -= 1
                try context.save()
            }
        }
    }

    func getCategoryFrom(tracker: Tracker) -> String? {
        let request = NSFetchRequest<TrackerCoreData>(
            entityName: "TrackerCoreData"
        )
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(
            format: "%K == %@", #keyPath(TrackerCoreData.trackerID), tracker.trackerID
        )
        guard let result = try? context.fetch(request),
              let tracker = result.first else {
            print("Tracker not found")
            return nil
        }

        return tracker.category?.title
    }
}
