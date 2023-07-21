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

    private let dateFormatter = DateFormatter()
    private let datePicker = UIDatePicker()
  
    override func loadView() {
        super.loadView()
        view = trackersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setObservers()
        checkStubImage()
        setGestureRecognizer()
        setNavigationBar()
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
        dateSelected(date: selectedDate)
        trackersView.collectionView.reloadData()
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc
    private func createHabitButtonTap() {
        dismissKeyboard()
        let navigationController = UINavigationController()

        let createMainVC = CreateMainVC()
        createMainVC.createMainView.delegate = createMainVC

        navigationController.setViewControllers([createMainVC], animated: true)

        navigationController.modalPresentationStyle = .formSheet
        present(navigationController, animated: true)
    }

    @objc
    private func datePickerTap(_ sender: UIDatePicker) {
        let selectedDate = datePicker.date
        dateSelected(date: selectedDate)
    }

    private func checkStubImage() {
        if !visibleCategories.isEmpty {
            trackersView.stubText.isHidden = true
            trackersView.stubImage.isHidden = true
        } else {
            trackersView.stubText.isHidden = false
            trackersView.stubImage.isHidden = false
        }
    }

    private func setNavigationBar() {
        let image = UIImage(systemName: "plus")
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 21, weight: .semibold)
        let largeImage = image?.withConfiguration(imageConfig)

        let leftBarButton = UIBarButtonItem(
            image: largeImage,
            style: .plain,
            target: self,
            action: #selector(createHabitButtonTap)
        )
        navigationItem.leftBarButtonItem = leftBarButton

        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .ypDateGray
        datePicker.addTarget(self, action: #selector(datePickerTap(_:)), for: .valueChanged)

        let rightBarButton = UIBarButtonItem(customView: datePicker)
        navigationItem.rightBarButtonItem = rightBarButton
    }

    private func setGestureRecognizer() {
        let tap = UITapGestureRecognizer(
            target: self, action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }

    private func setObservers() {
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
    }

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

        if visibleCategories.isEmpty {

        }
        checkStubImage()
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

        guard let selectedDateOnly = calendar.date(
            from: selectedDateComponents
        ),
              let currentDateOnly = calendar.date(
                  from: currentDateComponents
              ) else {
            return
        }

        if selectedDateOnly <= currentDateOnly {
            let trackerId = visibleCategories[indexPath.section].trackers[indexPath.row].id

            if completedTrackers.contains(where: { tracker in
                let dateComponents = calendar.dateComponents(
                    [.year, .month, .day], from: tracker.date
                )
                let dateOnly = calendar.date(from: dateComponents)
                return tracker.id == trackerId && dateOnly == selectedDateOnly
            }) {
                visibleCategories[indexPath.section].trackers[indexPath.row].dayCounter -= 1
                if let index = completedTrackers.firstIndex(where: { tracker in
                    let dateComponents = calendar.dateComponents(
                        [.year, .month, .day], from: tracker.date
                    )
                    let dateOnly = calendar.date(from: dateComponents)
                    return tracker.id == trackerId && dateOnly == selectedDateOnly
                }) {
                    completedTrackers.remove(at: index)
                }
            } else {
                visibleCategories[indexPath.section].trackers[indexPath.row].dayCounter += 1
                let completedTracker = visibleCategories[indexPath.section].trackers[indexPath.row]
                completedTrackers.append(TrackerRecord(id: completedTracker.id, date: selectedDate))
            }

            if let index = categories.firstIndex(where: { $0.title == visibleCategories[indexPath.section].title }) {
                categories[index] = visibleCategories[indexPath.section]
            }
            trackersView.collectionView.reloadItems(at: [indexPath])
        }
    }
}

extension TrackersVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let searchText = textField.text, !searchText.isEmpty {
            visibleCategories = categories.map { category in
                var newCategory = category
                newCategory.trackers = category.trackers.filter {
                    $0.title.lowercased().contains(searchText.lowercased())
                }
                return newCategory
            }.filter { !$0.trackers.isEmpty }
        } else {
            dateSelected(date: selectedDate)
        }
        checkStubImage()
        trackersView.collectionView.reloadData()
    }
}
