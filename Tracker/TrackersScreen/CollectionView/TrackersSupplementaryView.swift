//
//  TrackersSupplementaryView.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 11.07.2023.
//

import UIKit

final class TrackerHeader: UICollectionReusableView {
    static let identifier = "TrackerHeader"

    let label: UILabel = {
        let label = UILabel()

        label.text = "Важное"
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
                equalTo: bottomAnchor,
                constant: -7
            ),
            label.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 12
            )
        ])
    }
}
