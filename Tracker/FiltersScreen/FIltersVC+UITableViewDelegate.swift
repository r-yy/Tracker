//
//  FIltersVC+UITableViewDelegate.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 09.08.2023.
//

import UIKit

extension FiltersVC: UITableViewDelegate {
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
        guard let cell = tableView.cellForRow(at: indexPath) as? FiltersCell else {
            return
        }

        cell.isChosen()
        delegate?.filterTrackers(filter: indexPath.row)

        navigationController?.dismiss(animated: true)
    }
}
