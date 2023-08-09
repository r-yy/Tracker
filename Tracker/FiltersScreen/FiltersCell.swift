//
//  FiltersCell.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 09.08.2023.
//

import UIKit

final class FiltersCell: UITableViewCell {
    static let identifier = "FiltersCell"

    private let cellLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(
            name: "SF Pro Text Regular",
            size: 17
        )
        label.textColor = .ypBlack

        return label
    }()

    private let view: UIView = {
        let view = UIView()

        view.backgroundColor = .ypGray

        return view
    }()

    private let checkmarkView: UIImageView = {
        let view = UIImageView()

        view.image = UIImage(systemName: "checkmark")

        return view
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

    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.layer.cornerRadius = 0
        view.isHidden = false
    }

    private func makeCell() {
        contentView.backgroundColor = .ypDateGray

        [cellLabel, view, checkmarkView].forEach { item in
            contentView.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false

        }

        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            cellLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            contentView.heightAnchor.constraint(
                equalToConstant: 75
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
                equalToConstant: 0.5
            ),
            checkmarkView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            checkmarkView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            )
        ])
        checkmarkView.isHidden = true
    }

    func configCell(title: String, numberOfRow: Int) {
        cellLabel.text = title
        if numberOfRow == 3 {
            view.isHidden = true
        }
    }

    func isChosen() {
        checkmarkView.isHidden = false
    }
}
