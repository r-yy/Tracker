//
//  ViewController.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class TrackersVC: UIViewController {
    private let datePicker = UIDatePicker()
    private let dataProvider: DataProviderProtocol

    lazy var trackersView: TrackersView = {
        let view = TrackersView()

        view.collectionView.dataSource = self
        view.collectionView.delegate = self
        view.searchView.delegate = self

        return view
    }()

    lazy var categories: [TrackerCategory] = []

    var visibleCategories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []
    var currentDate: Date = Date()
    var selectedDate: Date = Date()

    let dateManager: DateManager

    init() {
        dataProvider = DataProvider()
        dateManager = DateManager.shared
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        super.loadView()
        view = trackersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
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

        let createMainVC = CreateMainVC(dataProvider: dataProvider)
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
        let imageConfig = UIImage.SymbolConfiguration(
            pointSize: 21, weight: .semibold
        )
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
        datePicker.addTarget(
            self, action: #selector(datePickerTap(_:)), for: .valueChanged
        )

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
        let dayInWeek = dateManager.getDayInWeek(date: date)

        visibleCategories = categories.compactMap { category in
            let filteredTrackers = category.trackers.filter {
                $0.schedule?.contains(dayInWeek) == true
            }

            if !filteredTrackers.isEmpty {
                var newCategory = category
                newCategory.trackers = filteredTrackers
                return newCategory
            } else {
                return nil
            }
        }

        if visibleCategories.isEmpty {

        }
        checkStubImage()
        trackersView.collectionView.reloadData()
    }

    private func getData() {
        categories = dataProvider.getCategories()

        let dayInWeek = dateManager.getDayInWeek(date: currentDate)

        visibleCategories = categories.compactMap { category in
            let filteredTrackers = category.trackers.filter {
                $0.schedule?.contains(dayInWeek) == true
            }

            if !filteredTrackers.isEmpty {
                var newCategory = category
                newCategory.trackers = filteredTrackers
                return newCategory
            } else {
                return nil
            }
        }

        completedTrackers = dataProvider.getTrackerRecords()
    }
}

extension TrackersVC: TrackersControllerDelegate {
    func plusButtonTap(cell: TrackersCell) {
        guard let indexPath = trackersView.collectionView.indexPath(for: cell) else {
            return
        }
        let selectedDateOnly = dateManager.getDateOnly(date: selectedDate)
        let currentDateOnly = dateManager.getDateOnly(date: currentDate)

        if selectedDateOnly <= currentDateOnly {
            let trackerId = visibleCategories[indexPath.section]
                .trackers[indexPath.row].trackerID

            if completedTrackers.contains(where: { tracker in
                let dateOnly = dateManager.getDateOnly(date: tracker.date)
                return tracker.trackerID == trackerId && dateOnly == selectedDateOnly
            }) {
                visibleCategories[indexPath.section]
                    .trackers[indexPath.row].dayCounter -= 1
                if let index = completedTrackers.firstIndex(where: { tracker in
                    let dateOnly = dateManager.getDateOnly(date: tracker.date)
                    return tracker.trackerID == trackerId && dateOnly == selectedDateOnly
                }) {

                    completedTrackers.remove(at: index)
                    let completedTracker = visibleCategories[indexPath.section]
                        .trackers[indexPath.row]
                    let trackerRecord = TrackerRecord(
                        trackerID: completedTracker.trackerID, date: selectedDate
                    )
                    dataProvider.removeTrackerRecord(
                        trackerID: trackerRecord.trackerID, date: selectedDate
                    )
                    dataProvider.decreaseDayCounter(
                        trackerID: visibleCategories[indexPath.section]
                            .trackers[indexPath.row].trackerID
                    )
                }
            } else {
                visibleCategories[indexPath.section]
                    .trackers[indexPath.row].dayCounter += 1
                let completedTracker = visibleCategories[indexPath.section]
                    .trackers[indexPath.row]
                let trackerRecord = TrackerRecord(
                    trackerID: completedTracker.trackerID, date: selectedDate
                )
                completedTrackers.append(trackerRecord)
                dataProvider.addTrackerRecord(record: trackerRecord)
                dataProvider.increaseDayCounter(trackerID: visibleCategories[indexPath.section].trackers[indexPath.row].trackerID)
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
