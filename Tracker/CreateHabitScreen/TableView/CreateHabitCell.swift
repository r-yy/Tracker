//
//  CreateHabitCell.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class CreateHabitCell: UITableViewCell {
    static let identifier = "CreateHabitCell"

    let cellText: UILabel = {
        let label = UILabel()

        label.font = UIFont(
            name: "SF Pro Text Regular",
            size: 16
        )
        label.textColor = .ypBlack

        return label
    }()

    let cellSubText: UILabel = {
        let label = UILabel()

        label.font = UIFont(
            name: "SF Pro Text Regular",
            size: 16
        )
        label.textColor = .ypGray

        return label
    }()

    var topConstraint: NSLayoutConstraint?

    override init(
        style: UITableViewCell.CellStyle, reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeCell()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func makeCell() {
        self.accessoryType = .disclosureIndicator
        contentView.layer.masksToBounds = true
        backgroundColor = .ypDateGray

        contentView.addSubview(cellText)
        contentView.addSubview(cellSubText)

        cellText.translatesAutoresizingMaskIntoConstraints = false
        cellSubText.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cellText.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            cellText.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            cellSubText.topAnchor.constraint(
                equalTo: cellText.bottomAnchor,
                constant: 2
            ),
            cellSubText.leadingAnchor.constraint(
                equalTo: cellText.leadingAnchor
            )
        ])

        topConstraint = cellText.centerYAnchor.constraint(
            equalTo: contentView.centerYAnchor
        )
        topConstraint?.isActive = true

        cellSubText.isHidden = true
    }

    func configCell(
        indexPath: IndexPath, category: String?, weekdays: [String]?
    ) {
        if indexPath.row == 1 {
            cellText.text = "Расписание"
            if let weekdays = weekdays {
                let joinedDays = weekdays.joined(separator: ", ")
                cellSubText.text = joinedDays
                cellSubText.isHidden = false
                topConstraint?.constant = -10
                return
            } else {
                cellSubText.isHidden = true
                return
            }
        } else {
            cellText.text = "Категория"
            if let subtitle = category {
                cellSubText.text = subtitle
                cellSubText.isHidden = false
                topConstraint?.constant = -10
                return
            } else {
                cellSubText.isHidden = true
                return
            }
        }
    }
}
