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
        delegate?.selectCategory(category: categories[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}
