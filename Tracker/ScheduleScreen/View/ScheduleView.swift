//
//  ScheduleView.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class ScheduleView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(
            ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.identifier
        )
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 16

        return tableView
    }()

    let createButton: UIButton = {
        let button = UIButton()

        button.setTitle("Готово", for: .normal)
        button.addTarget(
            nil, action: #selector(setDays), for: .touchUpInside
        )
        button.titleLabel?.font = UIFont(
            name: "SF Pro Text Regular",
            size: 16
        )
        button.backgroundColor = .ypBlack
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16

        return button
    }()

    weak var delegate: ScheduleDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc
    private func setDays() {
        delegate?.setDays()
    }

    private func makeView() {
        backgroundColor = .ypWhite

        addSubview(createButton)
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false

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
                equalToConstant: 525
            ),
            createButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -20
            ),
            createButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            ),
            createButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 20
            ),
            createButton.heightAnchor.constraint(
                equalToConstant: 60
            )
        ])
    }
}
