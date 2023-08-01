//
//  OnboardingView.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 27.07.2023.
//

import UIKit

final class OnboardingView: UIView {
    let backgroundImage: UIImageView = {
        let view = UIImageView()

        view.isUserInteractionEnabled = true

        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "SF Pro Text Bold",size: 32)
        label.numberOfLines = 2
        label.textAlignment = .center

        return label
    }()

    let startButton: UIButton = {
        let button = UIButton()

        button.setTitle("Вот это технологии!", for: .normal)
        button.backgroundColor = .ypBlack
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.tintColor = .ypWhite
        button.addTarget(nil, action: #selector(startButtonTap), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "SF Pro Text Regular", size: 16)

        return button
    }()

    weak var delegate: OnboardingViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc
    private func startButtonTap() {
        UIView.animate(withDuration: 0.04, animations: { [weak self] in
            self?.startButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { [weak self] _ in
            UIView.animate(withDuration: 0.04, animations: {
                self?.startButton.transform = .identity
            })
        }
        delegate?.startApp()
    }

    private func makeView() {
        [backgroundImage, titleLabel, startButton].forEach { item in
            addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(
                equalTo: topAnchor
            ),
            backgroundImage.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            backgroundImage.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            backgroundImage.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            startButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -20
            ),
            startButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -50
            ),
            startButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 20
            ),
            startButton.heightAnchor.constraint(
                equalToConstant: 60
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            titleLabel.bottomAnchor.constraint(
                equalTo: startButton.topAnchor,
                constant: -180
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            )
        ])
    }

    func configView(page: Int) {
        if page == 0 {
            backgroundImage.image = UIImage(named: "onboardingFirstSlide")
            titleLabel.text = "Отслеживайте только то, что хотите"
        } else {
            backgroundImage.image = UIImage(named: "onboardingSecondSlide")
            titleLabel.text = "Даже если это не литры воды и йога"
        }
    }
}
