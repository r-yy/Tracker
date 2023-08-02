//
//  CategoriesCell.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 11.07.2023.
//

import UIKit

final class CategoriesCell: UITableViewCell {
    static let identifier = "CategoriesCell"

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

    var viewModel: CategoriesCellModel? {
        didSet {
            guard let viewModel else { return }
            checkmarkView.isHidden = !viewModel.isChosen
            cellLabel.text = viewModel.title
            if viewModel.isLastCategory {
                contentView.clipsToBounds = true
                contentView.layer.cornerRadius = 16
                contentView.layer.maskedCorners = [
                    .layerMaxXMaxYCorner, .layerMinXMaxYCorner
                ]
                view.isHidden = true
            }
        }
    }

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
                equalToConstant: 1
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
}
