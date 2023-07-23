//
//  CategoriesTableViewDelegate.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 11.07.2023.
//

import UIKit

extension CategoriesVC: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
            return 75
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoriesCell else {
            return
        }
        cell.checkmarkView.isHidden = false
        delegate?.selectCategory(category: categories[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}
