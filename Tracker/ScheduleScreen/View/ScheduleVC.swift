//
//  ScheduleVC.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class ScheduleVC: UIViewController {
    lazy var scheduleView: ScheduleView = {
        let view = ScheduleView()
        view.tableView.dataSource = self
        return view
    }()

    private var selectedDays = [DayOfWeek]()

    override func loadView() {
        super.loadView()
        view = scheduleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
    }

    private func setTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Расписание"
        titleLabel.textColor = .ypBlack
        titleLabel.font = UIFont(
            name: "SF Pro Text Regular",
            size: 18
        )
        self.navigationItem.titleView = titleLabel
    }
}

extension ScheduleVC: ScheduleDelegate {
    func setDays() {
        selectedDays.sort(by: { $0.rawValue < $1.rawValue })

        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "SetWeekdays"),
            object: nil,
            userInfo: ["SelectedDays": selectedDays]
        )
        
        navigationController?.popViewController(animated: true)
    }

    func addDay(cell: ScheduleCell) {
        guard let indexPath = scheduleView.tableView.indexPath(for: cell),
              let weekday = DayOfWeek(rawValue: indexPath.row) else {
            return
        }
        selectedDays.append(weekday)
    }
}
