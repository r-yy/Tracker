//
//  DataProvider.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 22.07.2023.
//

import UIKit
import CoreData

final class DataProvider: NSObject {
    private let modelName = "Tracker"
    private let storeURL = NSPersistentContainer
                                .defaultDirectoryURL()
                                .appendingPathComponent("data-store.sqlite")

    private let container: NSPersistentContainer

    private lazy var trackerDataStore: TrackerDataStore? = {
        do {
            return try TrackerStore(dataProvider: self)
        } catch {
            print("Failed to initialize TrackerStore: \(error)")
            return nil
        }
    }()

    private lazy var trackerCategoryDataStore: TrackerCategoryDataStore? = {
        do {
            return try TrackerCategoryStore(dataProvider: self)
        } catch {
            print("Failed to initialize TrackerCategoryStore: \(error)")
            return nil
        }
    }()

    private lazy var trackerRecordDataStore: TrackerRecordDataStore? = {
        do {
            return try TrackerRecordStore(dataProvider: self)
        } catch {
            print("Failed to initialize TrackerRecordStore: \(error)")
            return nil
        }
    }()

    private var trackerFetchedResultsController:
    NSFetchedResultsController<TrackerCoreData> {

        let fetchRequest = NSFetchRequest<TrackerCoreData>(
            entityName: "TrackerCoreData"
        )
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "dayCounter", ascending: false)
        ]

        let trackerFetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        try? trackerFetchedResultsController.performFetch()
        return trackerFetchedResultsController
    }

    private var trackerCategoryFetchedResultsController:
    NSFetchedResultsController<TrackerCategoryCoreData> {

        let fetchRequest = NSFetchRequest<TrackerCategoryCoreData>(
            entityName: "TrackerCategoryCoreData"
        )
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "title", ascending: false)
        ]

        let trackerCategoryFetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        try? trackerCategoryFetchedResultsController.performFetch()
        return trackerCategoryFetchedResultsController
    }

    private var trackerRecordFetchedResultsController:
    NSFetchedResultsController<TrackerRecordCoreData> {

        let fetchRequest = NSFetchRequest<TrackerRecordCoreData>(
            entityName: "TrackerRecordCoreData"
        )
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]

        let trackerRecordFetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        try? trackerRecordFetchedResultsController.performFetch()
        return trackerRecordFetchedResultsController
    }

    let context: NSManagedObjectContext

    override init() {
        container = NSPersistentContainer(name: "Tracker")
            container.loadPersistentStores { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
        context = container.viewContext
    }
}

extension DataProvider: DataProviderProtocol {
    func addTracker(tracker: Tracker) {
        try? trackerDataStore?.add(tracker)
    }

    func addTrackerCategory(category: TrackerCategory) {
        try? trackerCategoryDataStore?.add(category)

    }

    func addTrackerRecord(record: TrackerRecord) {
        try? trackerRecordDataStore?.add(record)
    }

    func getCategories() -> [TrackerCategory] {
        guard let fetchedObjects = trackerCategoryFetchedResultsController
            .fetchedObjects else { return [] }

        var categoriesDict = [String: [Tracker]]()

        for coreDataCategory in fetchedObjects {
            let trackers = coreDataCategory.trackers?.allObjects as? [TrackerCoreData]
            let mappedTrackers = trackers?.map { coreDataTracker in
                return Tracker(
                    trackerID: coreDataTracker.trackerID ?? "",
                    title: coreDataTracker.title ?? "",
                    color: UIColor(hex: coreDataTracker.color ?? "FFFFFF"),
                    emoji: coreDataTracker.emoji ?? "",
                    schedule: coreDataTracker.schedule?.components(separatedBy: ","),
                    dayCounter: Int(coreDataTracker.dayCounter),
                    isPinned: coreDataTracker.isPinned,
                    initialCategory: coreDataTracker.initialCategory ?? ""
                )
            } ?? []

            if let title = coreDataCategory.title {
                if categoriesDict[title] != nil {
                    categoriesDict[title]!.append(contentsOf: mappedTrackers)
                } else {
                    categoriesDict[title] = mappedTrackers
                }
            }
        }

        return categoriesDict.map { title, trackers in
            return TrackerCategory(title: title, trackers: trackers)
        }
    }

    func getTracker(by id: String) -> Tracker? {
        trackerDataStore?.getTracker(by: id)
    }

    func getTrackerCoreData(by id: String) -> TrackerCoreData? {
        trackerDataStore?.getTrackerCoreData(by: id)
    }

    func getTrackerRecords() -> [TrackerRecord] {
        guard let fetchedObjects = trackerRecordFetchedResultsController
            .fetchedObjects else { return [] }

        return fetchedObjects.map { fetchedObject in
            return TrackerRecord(
                trackerID: fetchedObject.trackerID ?? "",
                date: fetchedObject.date ?? Date()
            )
        }
    }

    func increaseDayCounter(trackerID: String) {
        try? trackerDataStore?.increaseDayCounter(trackerID: trackerID)
    }

    func removeTrackerRecord(trackerID: String, date: Date) {
        try? trackerRecordDataStore?.removeTrackerRecord(
            trackerID: trackerID, date: date
        )
    }

    func decreaseDayCounter(trackerID: String) {
        try? trackerDataStore?.decreaseDayCounter(trackerID: trackerID)
    }

    func getCategoryFrom(tracker: Tracker) -> String? {
        trackerDataStore?.getCategoryFrom(tracker: tracker)
    }

    func editTracker(trackerCategory: TrackerCategory) {
        try? trackerCategoryDataStore?.updateTracker(trackerCategory: trackerCategory)
    }
}
