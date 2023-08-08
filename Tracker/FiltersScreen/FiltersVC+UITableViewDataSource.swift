//
//  FiltersVC+UITableViewDataSource.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 09.08.2023.
//

import UIKit

extension FiltersVC: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 4
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FiltersCell.identifier
        ) as? FiltersCell else {
            return UITableViewCell()
        }

        cell.configCell(
            title: tableViewStrings[indexPath.row], numberOfRow: indexPath.row
        )

        return cell
    }
}
