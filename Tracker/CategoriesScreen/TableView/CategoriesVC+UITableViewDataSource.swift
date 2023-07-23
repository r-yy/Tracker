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

        let isLastCell = indexPath.row == categories.count - 1
        if categories[indexPath.row] == delegate?.categoryTitle {
            cell.checkmarkView.isHidden = false
        }
        cell.configCell(title: categories[indexPath.row], isLastCell: isLastCell)

        return cell
    }

    
}
