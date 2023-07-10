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

    override init(
        style: UITableViewCell.CellStyle, reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeCell()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configCell(indexPath: IndexPath) {
        if indexPath.row == 1 {
            cellText.text = "Расписание"
            return
        }
        cellText.text = "Категория"
    }

    private func makeCell() {
        self.accessoryType = .disclosureIndicator
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
