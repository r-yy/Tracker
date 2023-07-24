//
//  TrackerRecordStore.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 21.07.2023.
//

import CoreData

final class TrackerRecordStore {
    private let context: NSManagedObjectContext
    private let dateManager = DateManager.shared

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

extension TrackerRecordStore: TrackerRecordDataStore {
    func add(_ trackerRecord: TrackerRecord) throws {
        try performSync { context in
            Result {
                let trackerRecordData = TrackerRecordCoreData(
                    context: context
                )
                trackerRecordData.trackerID = trackerRecord.trackerID
                trackerRecordData.date = trackerRecord.date
                try context.save()
            }
        }
    }

    func removeTrackerRecord(trackerID: String, date: Date) throws {
        let request = NSFetchRequest<TrackerRecordCoreData>(
            entityName: "TrackerRecordCoreData"
        )
        let dateOnly = dateManager.getDateOnly(date: date)

        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(
            format: "%K == %@", #keyPath(TrackerRecordCoreData.trackerID), trackerID
        )
        guard let result = try? context.fetch(request),
              let tracker = result.first(where: { result in
                  let dateFromDataOnly = dateManager.getDateOnly(
                    date: result.date ?? Date()
                  )
                  return dateOnly == dateFromDataOnly
              }) else {
            print("Tracker to remove not found")
            return
        }

        try performSync { context in
            Result {
                context.delete(tracker)
                try context.save()
            }
        }
    }
}

