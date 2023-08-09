//
//  StatisticView.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class StatisticView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        let title = NSLocalizedString("STATISTIC_HEADER_LABEL", comment: "")

        label.text = title
        label.font = UIFont(
            name: "SF Pro Text Bold",
            size: 34
        )
        label.textColor = .ypBlack

        return label
    }()

    private let stubImage: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(named: "statisticScreenStub")

        return imageView
    }()

    private let stubText: UILabel = {
        let label = UILabel()
        let title = NSLocalizedString("STATISTIC_STUB_TITLE", comment: "")

        label.text = title
        label.font = UIFont(
            name: "SF Pro Text Regular",
            size: 12
        )

        return label
    }()

    private lazy var trackersCompletedView: UIView = {
        let view = UIView()

        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16

        return view
    }()

    private let trackersCompletedLabel: UILabel = {
        let label = UILabel()

        label.text = NSLocalizedString(
            "STATISTIC_TRACKERS_COMPLETED_TITLE", comment: ""
        )
        label.font = UIFont(
            name: "SF Pro Text Regular",
            size: 12
        )
        label.textColor = .ypBlack

        return label
    }()

    private let trackersCompletedCounter: UILabel = {
        let label = UILabel()

        label.font = UIFont(
            name: "SF Pro Text Bold",
            size: 34
        )
        label.textColor = .ypBlack
        label.text = "0"

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .ypWhite
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addRainbowBorder(to: trackersCompletedView, borderWidth: 1)
    }

    private func makeView() {
        [
            titleLabel,
            stubText,
            stubImage,
            trackersCompletedView,
            trackersCompletedLabel,
            trackersCompletedCounter
        ].forEach({ item in
            addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        })

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            stubImage.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor
            ),
            stubImage.centerYAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerYAnchor
            ),
            stubText.topAnchor.constraint(
                equalTo: stubImage.bottomAnchor,
                constant: 8
            ),
            stubText.centerXAnchor.constraint(
                equalTo: centerXAnchor
            ),
            trackersCompletedView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 77
            ),
            trackersCompletedView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            trackersCompletedView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            trackersCompletedView.heightAnchor.constraint(
                equalToConstant: 90
            ),
            trackersCompletedLabel.bottomAnchor.constraint(
                equalTo: trackersCompletedView.bottomAnchor,
                constant: -12
            ),
            trackersCompletedLabel.leadingAnchor.constraint(
                equalTo: trackersCompletedView.leadingAnchor,
                constant: 12
            ),
            trackersCompletedCounter.leadingAnchor.constraint(
                equalTo: trackersCompletedLabel.leadingAnchor
            ),
            trackersCompletedCounter.topAnchor.constraint(
                equalTo: trackersCompletedView.topAnchor,
                constant: 12
            )
        ])
    }

    private func addRainbowBorder(to view: UIView, borderWidth: CGFloat) {
        let rainbowColors: [CGColor] = [
            UIColor.ypRed.cgColor,
            UIColor.ypOrange.cgColor,
            UIColor.ypLightGreen.cgColor,
            UIColor.ypGreen.cgColor,
            UIColor.ypLightBlue.cgColor,
            UIColor.ypBlue.cgColor
        ]

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = rainbowColors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)

        let maskLayer = CAShapeLayer()

        let fullRectPath = UIBezierPath(rect: view.bounds)
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.fillRule = .evenOdd
        maskLayer.path = fullRectPath.cgPath

        let borderRectPath = UIBezierPath(
            roundedRect: view.bounds.insetBy(dx: borderWidth, dy: borderWidth),
            cornerRadius: view.layer.cornerRadius - borderWidth
        )
        borderRectPath.append(fullRectPath)
        maskLayer.path = borderRectPath.cgPath
        maskLayer.fillColor = UIColor.white.cgColor

        gradientLayer.mask = maskLayer

        view.layer.addSublayer(gradientLayer)
    }

    func isNeedHideStubs(_ hide: Bool) {
        stubText.isHidden = hide
        stubImage.isHidden = hide
        trackersCompletedView.isHidden = !hide
        trackersCompletedLabel.isHidden = !hide
        trackersCompletedCounter.isHidden = !hide
    }

    func setCompletedTrackersCounter(count: String) {
        trackersCompletedCounter.text = count
    }
}
