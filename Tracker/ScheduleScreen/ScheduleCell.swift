//
//  ScheduleCell.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class ScheduleCell: UITableViewCell {
    static let identifier = "ScheduleCell"

    let cellText: UILabel = {
        let label = UILabel()

        label.font = UIFont(
            name: "SF Pro Text Regular",
            size: 16
        )
        label.textColor = .ypBlack

        return label
    }()

    let toggleSwitch: UISwitch = {
        let toggleSwitch = UISwitch()

        toggleSwitch.addTarget(
            self, action: #selector(toggleSwitched), for: .valueChanged
        )
        toggleSwitch.onTintColor = .ypBlue

        return toggleSwitch
    }()

    override init(
        style: UITableViewCell.CellStyle, reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeCell()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc
    private func toggleSwitched(sender: UISwitch) {

    }

    func configCell(indexPath: IndexPath) {
        if let dayOfWeek = DayOfWeek(rawValue: indexPath.row) {
            cellText.text = dayOfWeek.longForm
        }
    }

    private func makeCell() {
        self.accessoryView = toggleSwitch
        contentView.layer.masksToBounds = true
        backgroundColor = .ypDateGray

        contentView.addSubview(cellText)
        cellText.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cellText.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            cellText.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            cellText.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            cellText.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            cellText.heightAnchor.constraint(
                equalToConstant: 75
            )
        ])
    }
}
