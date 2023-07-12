//
//  CategoriesCell.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 11.07.2023.
//

import UIKit

final class CategoriesCell: UITableViewCell {
    static let identifier = "CategoriesCell"

    let cellLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(
            name: "SF Pro Text Regular",
            size: 17
        )
        label.textColor = .ypBlack

        return label
    }()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style, reuseIdentifier: reuseIdentifier
        )
        makeCell()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func makeCell() {
        contentView.backgroundColor = .ypDateGray
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16

        contentView.addSubview(cellLabel)
        cellLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            cellLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            )
        ])
    }

    func configCell(title: String) {
        cellLabel.text = title
    }
}
