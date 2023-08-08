//
//  FiltersVC.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 08.08.2023.
//

import UIKit

final class FiltersVC: UIViewController {
    lazy var filtersView: FiltersView = {
        let view = FiltersView()

        view.tableView.delegate = self
        view.tableView.dataSource = self

        return view
    }()

    let tableViewStrings: [String] = [
        NSLocalizedString("FILTER_ALL_TRACKERS", comment: ""),
        NSLocalizedString("FILTER_CURRENT_TRACKERS", comment: ""),
        NSLocalizedString("FILTER_COMPLETED_TRACKERS", comment: ""),
        NSLocalizedString("FILTER_NOT_COMPLETED_TRACKERS", comment: "")
    ]

    weak var delegate: FiltersVCDelegate?

    override func loadView() {
        super.loadView()
        view = filtersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
    }

    private func setTitle() {
        let titleLabel = UILabel()
        let title = NSLocalizedString("FILTERS_HEADER_LABEL", comment: "")
        titleLabel.text = title
        titleLabel.textColor = .ypBlack
        titleLabel.font = UIFont(
            name: "SF Pro Text Regular",
            size: 18
        )
        self.navigationItem.titleView = titleLabel
    }
}
