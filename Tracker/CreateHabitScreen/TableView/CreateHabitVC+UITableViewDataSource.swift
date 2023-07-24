//
//  CreateHabitTableViewDataSource.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

extension CreateHabitVC: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return numberOfRows
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
            withIdentifier: CreateHabitCell.identifier
        ) as? CreateHabitCell else {
            return UITableViewCell()
        }

        let isLastCell = indexPath.row == numberOfRows - 1
        cell.configCell(
            indexPath: indexPath,
            category: categoryTitle,
            weekdays: trackerSchedule,
            isLastCell: isLastCell
        )

        return cell
    }
}
