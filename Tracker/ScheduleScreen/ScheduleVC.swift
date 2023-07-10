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
//        view.tableView.delegate = self

        return view
    }()

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
        let createHabitVC = CreateHabitVC(isHabit: true)
        createHabitVC.createHabitView.delegate = createHabitVC
        createHabitVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(createHabitVC, animated: true)
    }
}
