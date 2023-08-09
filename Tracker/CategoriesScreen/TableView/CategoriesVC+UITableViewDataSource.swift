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
        return categoriesViewModel.categories.count
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

        let isLastCategory = indexPath.row == categoriesViewModel.categories.count - 1
        let isChosen = categoriesViewModel.categories[indexPath.row] == delegate?.categoryTitle
        let title = categoriesViewModel.categories[indexPath.row]
        let categoriesCellModel = CategoriesCellModel(title: title, isChosen: isChosen, isLastCategory: isLastCategory)

        cell.viewModel = categoriesCellModel

        return cell
    }
}
