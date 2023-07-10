//
//  CreateHabitTableViewDataSource.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

extension CreateHabitVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isHabit == true ? 2 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
            withIdentifier: CreateHabitCell.identifier
        ) as? CreateHabitCell else {
            return UITableViewCell()
        }

        cell.configCell(indexPath: indexPath)

        return cell
    }
}
