//
//  HabitCollectionViewCell.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class HabitCollectionViewCell: UICollectionViewCell {
    static let identifier = "HabitCollectionViewCell"

    let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()

    let colorView: UIView = {
        let view = UIView()

        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 15

        makeCell()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func makeCell() {
        contentView.addSubview(emojiLabel)
        contentView.addSubview(colorView)

        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        colorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            emojiLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            colorView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 7
            ),
            colorView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -7
            ),
            colorView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -7
            ),
            colorView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 7
            )
        ])
    }

    func configEmojiCell(emoji: String) {
        emojiLabel.text = emoji
    }

    func configColorCell(color: UIColor) {
        colorView.backgroundColor = color
    }

    func selectCellWithFill() {
        contentView.backgroundColor = .ypGray.withAlphaComponent(0.3)
    }

    func selectCellWithOutline(color: UIColor) {
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = color.withAlphaComponent(0.3).cgColor
    }

    func resetSelectionStyle() {
        contentView.layer.borderWidth = 0
        contentView.backgroundColor = .clear
    }
}
