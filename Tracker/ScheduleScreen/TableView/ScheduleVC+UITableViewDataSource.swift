//
//  ScheduleTableViewDataSource.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

extension ScheduleVC: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 7
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
            withIdentifier: ScheduleCell.identifier
        ) as? ScheduleCell else {
            return UITableViewCell()
        }

        cell.delegate = self
        cell.configCell(indexPath: indexPath)

        return cell
    }
}
