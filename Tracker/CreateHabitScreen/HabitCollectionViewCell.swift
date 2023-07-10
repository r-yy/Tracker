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

    let emojiArray: [String] = [
        "😀", "🐶", "🌳", "🚗", "🏡", "🍎", "🎈", "⚽",
        "🌞", "🍕", "🚀", "🎵", "📚", "🎁", "⏰", "💡",
        "👓", "🎧"
    ]

    let colorsArray: [UIColor] = [
        UIColor(hex: "FD4C49"),
        UIColor(hex: "FF881E"),
        UIColor(hex: "007BFA"),
        UIColor(hex: "6E44FE"),
        UIColor(hex: "33CF69"),
        UIColor(hex: "E66DD4"),
        UIColor(hex: "F9D4D4"),
        UIColor(hex: "34A7FE"),
        UIColor(hex: "46E69D"),
        UIColor(hex: "35347C"),
        UIColor(hex: "FF674D"),
        UIColor(hex: "FF99CC"),
        UIColor(hex: "F6C48B"),
        UIColor(hex: "7994F5"),
        UIColor(hex: "832CF1"),
        UIColor(hex: "AD56DA"),
        UIColor(hex: "8D72E6"),
        UIColor(hex: "2FD058")
    ]

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

    func configCell(indexPath: IndexPath) {
        if indexPath.section == 0 {
            emojiLabel.text = emojiArray[indexPath.row]
            colorView.isHidden = true
            emojiLabel.isHidden = false
        } else {
            colorView.backgroundColor = colorsArray[indexPath.row]
            colorView.isHidden = false
            emojiLabel.isHidden = true
        }
    }
}
