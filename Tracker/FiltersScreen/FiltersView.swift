//
//  FiltersView.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 08.08.2023.
//

import UIKit

final class FiltersView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(
            FiltersCell.self,
            forCellReuseIdentifier: FiltersCell.identifier
        )
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .none


        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func makeView() {
        backgroundColor = .ypWhite

        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 24
            ),
            tableView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            tableView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            tableView.heightAnchor.constraint(
                equalToConstant: 300
            )
        ])
    }
}
