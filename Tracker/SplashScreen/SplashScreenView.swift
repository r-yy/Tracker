//
//  SplashScreenView.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 28.07.2023.
//

import UIKit

final class SplashScreenView: UIView {
    let iconImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "launchScreen")
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func makeView() {
        backgroundColor = .ypBlue
        addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconImage.centerXAnchor.constraint(
                equalTo: centerXAnchor
            ),
            iconImage.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
            iconImage.heightAnchor.constraint(
                equalToConstant: 94
            ),
            iconImage.widthAnchor.constraint(
                equalToConstant: 91
            )
        ])

    }
}
