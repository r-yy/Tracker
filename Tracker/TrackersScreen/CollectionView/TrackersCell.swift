//
//  TrackersCell.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 11.07.2023.
//

import UIKit

final class TrackersCell: UICollectionViewCell {
    static let identifier = "TrackersCell"

    private let colorView: UIView = {
        let view = UIView()

        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16

        return view
    }()

    private let emojiLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()

        label.textColor = .white
        label.font = UIFont(
            name: "SF Pro Text Regular",
            size: 12
        )

        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()

        label.textColor = .ypBlack
        label.font = UIFont(
            name: "SF Pro Text Regular",
            size: 12
        )

        return label
    }()

    private let plusButton: UIButton = {
        let button = UIButton()

        button.tintColor = .ypWhite
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 17
        button.addTarget(nil, action: #selector(plusButtonTap), for: .touchUpInside)

        return button
    }()

    weak var delegate: TrackersControllerDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeCell()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc
    private func plusButtonTap() {
        delegate?.plusButtonTap(cell: self)
    }

    private func makeCell() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16



        contentView.addSubview(colorView)
        colorView.addSubview(emojiLabel)
        colorView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(plusButton)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            colorView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            colorView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -58
            ),
            colorView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            emojiLabel.leadingAnchor.constraint(
                equalTo: colorView.leadingAnchor,
                constant: 12
            ),
            emojiLabel.topAnchor.constraint(
                equalTo: colorView.topAnchor,
                constant: 12
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: colorView.trailingAnchor,
                constant: -12
            ),
            titleLabel.bottomAnchor.constraint(
                equalTo: colorView.bottomAnchor,
                constant: -12
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: colorView.leadingAnchor,
                constant: 12
            ),
            dateLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -24
            ),
            dateLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 12
            ),
            plusButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -12
            ),
            plusButton.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16
            ),
            plusButton.widthAnchor.constraint(
                equalToConstant: 34
            ),
            plusButton.heightAnchor.constraint(
                equalToConstant: 34
            )
        ])
    }

    func configCell(
        backgroundColor: UIColor,
        emojilabel: String,
        titleLabel: String,
        dayCounter: Int,
        isTrackerCompleted: Bool
    ) {
        colorView.backgroundColor = backgroundColor
        self.emojiLabel.text = emojilabel
        self.titleLabel.text = titleLabel
        dateLabel.text = String.localizedStringWithFormat(
            NSLocalizedString("NUMBER_OF_DAYS", comment: ""), dayCounter
        )

        if isTrackerCompleted {
            let image = UIImage(systemName: "checkmark")
            let imageConfig = UIImage.SymbolConfiguration(
                pointSize: 15, weight: .semibold
            )
            let smallImage = image?.withConfiguration(imageConfig)
            plusButton.setImage(smallImage, for: .normal)
            plusButton.backgroundColor = backgroundColor.withAlphaComponent(0.3)
        } else {
            let image = UIImage(systemName: "plus")
            let imageConfig = UIImage.SymbolConfiguration(
                pointSize: 15, weight: .semibold
            )
            let smallImage = image?.withConfiguration(imageConfig)
            plusButton.setImage(smallImage, for: .normal)
            plusButton.backgroundColor = backgroundColor
        }
    }
}
