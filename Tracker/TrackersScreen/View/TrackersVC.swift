//
//  ViewController.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class TrackersVC: UIViewController {
    private let datePicker = UIDatePicker()
    let dataProvider: DataProviderProtocol

    lazy var trackersView: TrackersView = {
        let view = TrackersView()

        view.collectionView.dataSource = self
        view.collectionView.delegate = self
        view.searchView.delegate = self
        view.delegate = self

        return view
    }()

    lazy var categories: [TrackerCategory] = []

    var visibleCategories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []
    var currentDate: Date = Date()
    var selectedDate: Date = Date()

    let dateManager: DateManager

    weak var statisticDelegate: StatisticDelegate?

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
        checkEmptyState()
        setGestureRecognizer()
        setNavigationBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AnalyticsService.report(event: "open", screen: "main", item: "")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AnalyticsService.report(event: "close", screen: "main", item: "")
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
        checkEmptyState()
    }

    @objc
    private func reloadCollectionView(notification: NSNotification) {
        getData()
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
        AnalyticsService.report(event: "click", screen: "main", item: "add_track")
    }

    @objc
    private func datePickerTap(_ sender: UIDatePicker) {
        let selectedDate = datePicker.date
        dateSelected(date: selectedDate)
    }

    private func checkEmptyState() {
        if !visibleCategories.isEmpty {
            trackersView.stubText.isHidden = true
            trackersView.stubImage.isHidden = true
            trackersView.filtersButton.isHidden = false
        } else {
            trackersView.stubText.isHidden = false
            trackersView.stubImage.isHidden = false
            trackersView.filtersButton.isHidden = true
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
        datePicker.layer.masksToBounds = true
        datePicker.layer.cornerRadius = 8
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

    private func getData() {
        categories = dataProvider.getCategories()

        if let pinnedCategoryIndex = categories.firstIndex(where: {
            $0.title == "Закрепленные"
        }) {
            let pinnedCategory = categories[pinnedCategoryIndex]
            categories.remove(at: pinnedCategoryIndex)
            categories.insert(pinnedCategory, at: 0)
        }

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

    private func updateTracker(_ category: TrackerCategory) {
        dataProvider.editTracker(trackerCategory: category)
        getData()
        trackersView.collectionView.reloadData()
    }

    private func showBottomSheet(tracker: Tracker) {
        let alertController = UIAlertController(
            title: NSLocalizedString("BOTTOM_SHEET_TITLE_LABEL", comment: ""),
            message: nil,
            preferredStyle: .actionSheet
        )

        let deleteAction = UIAlertAction(
            title: NSLocalizedString("BOTTOM_SHEET_DELETE_LABEL", comment: ""),
            style: .destructive
        ) { [weak self] _ in
            self?.dataProvider.deleteTracker(tracker: tracker)
            self?.getData()
            self?.trackersView.collectionView.reloadData()
            self?.checkEmptyState()
        }

        let cancelAction = UIAlertAction(
            title: NSLocalizedString("BOTTOM_SHEET_CANCEL_LABEL", comment: ""),
            style: .cancel
        )

        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
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

        checkEmptyState()
        trackersView.collectionView.reloadData()
    }

    func pinTracker(tracker: Tracker) {
        var pinnedTracker = tracker
        pinnedTracker.isPinned = true

        let category = TrackerCategory(title: "Закрепленные", trackers: [pinnedTracker])

        updateTracker(category)
    }

    func unpinTracker(tracker: Tracker) {
        var unpinnedTracker = tracker
        unpinnedTracker.isPinned = false

        let category = TrackerCategory(
            title: unpinnedTracker.initialCategory,
            trackers: [unpinnedTracker]
        )

        updateTracker(category)
    }

    func deleteTracker(tracker: Tracker) {
        showBottomSheet(tracker: tracker)
        AnalyticsService.report(event: "click", screen: "main", item: "delete")
    }

    func openEditorForTracker(tracker: Tracker) {
        let navigationController = UINavigationController()
        let createHabitVC = CreateHabitVC(
            isHabit: true,
            dataProvider: self.dataProvider,
            trackerToEdit: tracker
        )
        createHabitVC.createHabitView.delegate = createHabitVC

        navigationController.setViewControllers(
            [createHabitVC], animated: false
        )

        navigationController.modalPresentationStyle = .formSheet
        present(navigationController, animated: true)
        AnalyticsService.report(event: "click", screen: "main", item: "edit")
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
                    statisticDelegate?.updateTrackersCompletedRecord(
                        count: completedTrackers.count
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

                AnalyticsService.report(event: "click", screen: "main", item: "track")
            }

            if let index = categories.firstIndex(where: { $0.title == visibleCategories[indexPath.section].title }) {
                categories[index] = visibleCategories[indexPath.section]
            }
            trackersView.collectionView.reloadItems(at: [indexPath])
            statisticDelegate?.updateTrackersCompletedRecord(
                count: completedTrackers.count
            )
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
        checkEmptyState()
        trackersView.collectionView.reloadData()
    }
}

extension TrackersVC: TrackersViewDelegate {
    func openFilters() {
        let navigationController = UINavigationController()
        let filtersVC = FiltersVC()
        filtersVC.delegate = self

        navigationController.setViewControllers(
            [filtersVC], animated: false
        )

        navigationController.modalPresentationStyle = .formSheet
        self.present(navigationController, animated: true)
        AnalyticsService.report(event: "click", screen: "main", item: "filter")
    }
}

extension TrackersVC: FiltersVCDelegate {
    func filterTrackers(filter: Int) {
        switch filter {
        case 0:
            visibleCategories = categories
            trackersView.collectionView.reloadData()
            checkEmptyState()
        case 1:
            dateSelected(date: currentDate)
            datePicker.date = currentDate
        case 2:
            showCompletedTrackers()
        default:
            showIncompleteTrackers()
        }
    }

    private func showCompletedTrackers() {
        let completedTrackersFromBD = dataProvider.getTrackersRecord()
        getData()

        visibleCategories = visibleCategories.compactMap { category in
            var filteredCategory = category
            filteredCategory.trackers = category.trackers.filter { tracker in
                completedTrackersFromBD.contains { record in
                    let recordDate = dateManager.getDateOnly(date: record.date)
                    let currentDate = dateManager.getDateOnly(date: currentDate)
                    return record.trackerID == tracker.trackerID && recordDate == currentDate
                }
            }
            return filteredCategory.trackers.isEmpty ? nil : filteredCategory
        }
        trackersView.collectionView.reloadData()
        checkEmptyState()
    }

    private func showIncompleteTrackers() {
        let completedTrackersFromBD = dataProvider.getTrackersRecord()
        getData()

        visibleCategories = visibleCategories.compactMap { category in
            var filteredCategory = category
            filteredCategory.trackers = category.trackers.filter { tracker in
                !completedTrackersFromBD.contains { record in
                    let recordDate = dateManager.getDateOnly(date: record.date)
                    let currentDate = dateManager.getDateOnly(date: currentDate)
                    return record.trackerID == tracker.trackerID && recordDate == currentDate
                }
            }
            return filteredCategory.trackers.isEmpty ? nil : filteredCategory
        }
        trackersView.collectionView.reloadData()
        checkEmptyState()
    }
}
