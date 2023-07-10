//
//  CollectionViewHeaders.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 11.07.2023.
//

import UIKit

final class EmojiHeader: UICollectionReusableView {
    static let identifier = "EmojiHeader"

    let label: UILabel = {
        let label = UILabel()

        label.text = "Emoji"
        label.font = UIFont(
            name: "SF Pro Text Bold",
            size: 19
        )

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func makeView() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(
                equalTo: topAnchor
            ),
            label.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            label.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            label.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 28
            )
        ])
    }
}

final class ColorsHeader: UICollectionReusableView {
    static let identifier = "ColorsHeader"

    let label: UILabel = {
        let label = UILabel()

        label.text = "Цвет"
        label.font = UIFont(
            name: "SF Pro Text Bold",
            size: 19
        )

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func makeView() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(
                equalTo: topAnchor
            ),
            label.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            label.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            label.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 28
            )
        ])
    }
}

final class SpaceFooter: UICollectionReusableView {
    static let identifier = "SpaceFooter"

    let label: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func makeView() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(
                equalTo: topAnchor
            ),
            label.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            label.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            label.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 28
            )
        ])
    }
}
