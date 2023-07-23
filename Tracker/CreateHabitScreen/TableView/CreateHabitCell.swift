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

    let view: UIView = {
        let view = UIView()

        view.backgroundColor = .ypGray

        return view
    }()

    let chevronImageView: UIImageView = {
        let view = UIImageView()
        let image = UIImage(systemName: "chevron.right")?.withTintColor(
            .gray, renderingMode: .alwaysOriginal
        )
        view.image = image
        return view
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
        contentView.layer.masksToBounds = true
        backgroundColor = .ypDateGray

        [cellText, cellSubText, view, chevronImageView].forEach { item in
            contentView.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false

        }

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
            ),
            view.topAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -1
            ),
            view.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
            view.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            view.heightAnchor.constraint(
                equalToConstant: 1
            ),
            chevronImageView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            chevronImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            )
        ])

        topConstraint = cellText.centerYAnchor.constraint(
            equalTo: contentView.centerYAnchor
        )
        topConstraint?.isActive = true

        cellSubText.isHidden = true
    }

    func configCell(
        indexPath: IndexPath, category: String?, weekdays: [String]?, isLastCell: Bool
    ) {
        if isLastCell {
            view.isHidden = true
        }

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
