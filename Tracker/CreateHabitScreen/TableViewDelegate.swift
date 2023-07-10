//
//  CreateHabitTableViewDelegate.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

extension CreateHabitVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let categoriesVC = CategoriesVC()
            categoriesVC.categoriesView.delegate = categoriesVC
            categoriesVC.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(categoriesVC, animated: true)
        } else {
            let scheduleVC = ScheduleVC()
            scheduleVC.scheduleView.delegate = scheduleVC
            scheduleVC.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(scheduleVC, animated: true)
        }
    }
}
