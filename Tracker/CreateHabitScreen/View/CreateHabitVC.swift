//
//  CreateHabitVC.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class CreateHabitVC: UIViewController {
    private var isHabit: Bool
    
    lazy var createHabitView: CreateHabitView = {
        let view = CreateHabitView()

        view.tableView.dataSource = self
        view.tableView.delegate = self
        view.collectionView.dataSource = self
        view.collectionView.delegate = self
        view.textField.delegate = self
        view.createButton.isEnabled = isFormComplete

        return view
    }()

    let gridGeometric = GridGeometric(
        cellCount: 6, leftInset: 5, rightInset: 5, cellSpacing: 5
    )

    let emojiArray: [String] = [
        "😀", "🐶", "🌳", "🚗", "🏡", "🍎", "🎈", "⚽",
        "🌞", "🍕", "🚀", "🎵", "📚", "🎁", "⏰", "💡",
        "👓", "🎧"
    ]

    let colorsArray: [UIColor] = [
        UIColor(hex: "FD4C49"),
        UIColor(hex: "FF881E"),
        UIColor(hex: "007BFA"),
        UIColor(hex: "6E44FE"),
        UIColor(hex: "33CF69"),
        UIColor(hex: "E66DD4"),
        UIColor(hex: "F9D4D4"),
        UIColor(hex: "34A7FE"),
        UIColor(hex: "46E69D"),
        UIColor(hex: "35347C"),
        UIColor(hex: "FF674D"),
        UIColor(hex: "FF99CC"),
        UIColor(hex: "F6C48B"),
        UIColor(hex: "7994F5"),
        UIColor(hex: "832CF1"),
        UIColor(hex: "AD56DA"),
        UIColor(hex: "8D72E6"),
        UIColor(hex: "2FD058")
    ]

    var categoryTitle: String? {
        didSet {
            updateButtonAppearance()
        }
    }
    var trackerTitle = String() {
        didSet {
            updateButtonAppearance()
        }
    }
    var trackerEmoji = String() {
        didSet {
            updateButtonAppearance()
        }
    }
    var trackerColor: UIColor = .black {
        didSet {
            updateButtonAppearance()
        }
    }
    var trackerSchedule: [String]?

    var isFormComplete: Bool {
        return categoryTitle != nil &&
            !trackerTitle.isEmpty &&
            !trackerEmoji.isEmpty &&
            trackerColor != .black
    }

    var selectedIndexPaths: [Int: IndexPath] = [:]
    var numberOfRows = Int()

    var dataProvider: DataProviderProtocol

    init(isHabit: Bool, dataProvider: DataProviderProtocol) {
        self.isHabit = isHabit
        numberOfRows = isHabit ? 2 : 1
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        super.loadView()
        view = createHabitView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setTableHeight()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setSelectedWeekdays(_:)),
            name: Notification.Name("SetWeekdays"),
            object: nil
        )

        let tap = UITapGestureRecognizer(
            target: self, action: #selector(dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc
    private func setSelectedWeekdays(_ notification: NSNotification) {
        guard let weekdays = notification.userInfo?["SelectedDays"] as? [DayOfWeek] else {
            return
        }
        trackerSchedule = []
        for weekday in weekdays {
            trackerSchedule?.append(weekday.shortForm)
        }
        createHabitView.tableView.reloadData()
    }

    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func updateButtonAppearance() {
        if isFormComplete {
            createHabitView.createButton.backgroundColor = .ypBlack
            createHabitView.createButton.isEnabled = true
        }
    }

    private func setTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Новая привычка"
        titleLabel.textColor = .ypBlack
        titleLabel.font = UIFont(
            name: "SF Pro Text Regular",
            size: 18
        )
        self.navigationItem.titleView = titleLabel
    }

    private func setTableHeight() {
        let height: CGFloat = isHabit ? 150 : 75
        NSLayoutConstraint.activate([
            createHabitView.tableView.heightAnchor.constraint(
                equalToConstant: height
            )
        ])
    }
}

extension CreateHabitVC: CreateHabitDelegate {
    func closeWindow() {
        self.dismiss(animated: true)
    }

    func createTracker() {
        if trackerSchedule == nil {
            trackerSchedule = [
                DayOfWeek.monday.shortForm,
                DayOfWeek.tuesday.shortForm,
                DayOfWeek.wednesday.shortForm,
                DayOfWeek.thursday.shortForm,
                DayOfWeek.friday.shortForm,
                DayOfWeek.saturday.shortForm,
                DayOfWeek.sunday.shortForm,
            ]
        }

        let tracker = Tracker(
            trackerID: UUID().uuidString,
            title: trackerTitle,
            color: trackerColor,
            emoji: trackerEmoji,
            schedule: trackerSchedule
        )

        dataProvider.addTracker(tracker: tracker)
        guard let savedTracker = dataProvider.getTracker(by: tracker.trackerID) else {
            return
        }
        let newTracker = TrackerCategory(
            title: categoryTitle ?? "",
            trackers: [savedTracker]
        )
        dataProvider.addTrackerCategory(category: newTracker)

        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "NotificationIdentifier"),
            object: nil,
            userInfo: ["newTracker": newTracker]
        )
        NotificationCenter.default.post(
            name: Notification.Name("TrackersUpdated"),
            object: nil
        )
        dismiss(animated: true)
    }

    func clearTextField() {
        createHabitView.textField.text = ""
        createHabitView.tableViewTopConstraint?.constant = 24
        createHabitView.warningLabel.isHidden = true
    }
}

extension CreateHabitVC: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }

        let updatedText = currentText.replacingCharacters(
            in: stringRange, with: string
        )

        if updatedText.count > 0 {
            createHabitView.clearButton.isHidden = false
        } else {
            createHabitView.clearButton.isHidden = true
        }

        if updatedText.count <= 38 {
            trackerTitle = updatedText
            createHabitView.tableViewTopConstraint?.constant = 24
            createHabitView.warningLabel.isHidden = true
            return true
        } else {
            createHabitView.tableViewTopConstraint?.constant = 62
            createHabitView.warningLabel.isHidden = false
            return false
        }

    }
}

extension CreateHabitVC: CategoriesSelectDelegate {
    func selectCategory(category: String) {
        categoryTitle = category
        createHabitView.tableView.reloadData()
    }
}
