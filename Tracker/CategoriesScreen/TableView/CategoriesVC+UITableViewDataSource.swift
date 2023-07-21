//
//  CategoriesTableViewDataSource.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 11.07.2023.
//

import UIKit

extension CategoriesVC: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return categories.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoriesCell.identifier
        ) as? CategoriesCell else {
            return UITableViewCell()
        }

        cell.configCell(title: categories[indexPath.row])

        return cell
    }

    
}
