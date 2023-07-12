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
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeCell()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func makeCell() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8

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
                equalTo: contentView.topAnchor
            ),
            colorView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            colorView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            colorView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            )
        ])
    }

    func configEmojiCell(emoji: String) {
        emojiLabel.text = emoji
    }

    func configColorCell(color: UIColor) {
        colorView.backgroundColor = color
    }
}
