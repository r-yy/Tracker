//
//  ViewController.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class TrackersVC: UIViewController {
    lazy var trackersView: TrackersView = {
        let view = TrackersView()

        view.collectionView.dataSource = self
        view.collectionView.delegate = self
        view.searchView.delegate = self

        return view
    }()

    var categories: [TrackerCategory] = []
    var visibleCategories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []
    let calendar = Calendar.current
    var currentDate: Date = Date()
    var selectedDate: Date = Date()
    var trackerTapStates: [String: Bool] = [:]

    private let dateFormatter = DateFormatter()
  
    override func loadView() {
        super.loadView()
        view = trackersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification(_:)),
            name: NSNotification.Name(rawValue: "NotificationIdentifier"),
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reloadCollectionView),
            name: Notification.Name("TrackersUpdated"),
            object: nil
        )

        checkStubImage()

        let tap = UITapGestureRecognizer(
            target: self, action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }

    @objc
    private func handleNotification(_ notification: NSNotification) {
        guard let newTracker = notification.userInfo?["newTracker"] as? TrackerCategory else {
            return
        }

        if let index = categories.firstIndex(where: {
            $0.title == newTracker.title
        }) {
            categories[index].trackers += newTracker.trackers
        } else {
            categories.append(newTracker)
        }
        visibleCategories = categories
        checkStubImage()
    }

    @objc
    private func reloadCollectionView(notification: NSNotification) {
        trackersView.collectionView.reloadData()
    }

    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func checkStubImage() {
        if !categories.isEmpty {
            trackersView.stubText.isHidden = true
            trackersView.stubImage.isHidden = true
        }
    }
}

extension TrackersVC: TabBarControllerDelegate {
    func dateSelected(date: Date) {
        selectedDate = date
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "E"
        let dayInWeek = dateFormatter.string(from: date).lowercased()

        visibleCategories = categories.filter { category in
            category.trackers.contains { tracker in
                if let schedule = tracker.schedule {
                    return schedule.contains { scheduledDay in
                        return scheduledDay.lowercased() == dayInWeek
                    }
                }
                return false
            }
        }
        trackersView.collectionView.reloadData()
    }
}

extension TrackersVC: TrackersControllerDelegate {
    func plusButtonTap(cell: TrackersCell) {
        guard let indexPath = trackersView.collectionView.indexPath(for: cell) else {
            return
        }
        let selectedDateComponents = calendar.dateComponents(
            [.year, .month, .day],
            from: selectedDate
        )
        let currentDateComponents = calendar.dateComponents(
            [.year, .month, .day],
            from: currentDate
        )

        let selectedDateOnly = calendar.date(
            from: selectedDateComponents
        )
        let currentDateOnly = calendar.date(
            from: currentDateComponents
        )

        if selectedDateOnly == currentDateOnly {
            let trackerId = categories[indexPath.section].trackers[indexPath.row].id

            if trackerTapStates[trackerId] == true {
                categories[indexPath.section].trackers[indexPath.row].dayCounter -= 1
                if let index = completedTrackers.firstIndex(where: { $0.id == trackerId && $0.date == currentDate }) {
                    completedTrackers.remove(at: index)
                }

                trackerTapStates[trackerId] = false
            } else {
                categories[indexPath.section].trackers[indexPath.row].dayCounter += 1
                let completedTracker = categories[indexPath.section].trackers[indexPath.row]
                completedTrackers.append(TrackerRecord(id: completedTracker.id, date: currentDate))

                trackerTapStates[trackerId] = true
            }
            visibleCategories = categories
            trackersView.collectionView.reloadItems(at: [indexPath])
        }
    }

}

extension TrackersVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
            if let searchText = textField.text, !searchText.isEmpty {
                visibleCategories = categories.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            } else {
                visibleCategories = categories
            }
            trackersView.collectionView.reloadData()
        }
}
