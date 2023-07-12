//
//  CreateView.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class CreateMainView: UIView {
    private let habitButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = .ypBlack
        button.setTitle("Привычка", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(
            nil, action: #selector(createHabit), for: .touchUpInside
        )
        button.titleLabel?.font = UIFont(
            name: "SF Pro Text Regular",
            size: 18
        )

        return button
    }()

    private let eventButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = .ypBlack
        button.setTitle("Нерегулярное событие", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(
            nil, action: #selector(createEvent), for: .touchUpInside
        )
        button.titleLabel?.font = UIFont(
            name: "SF Pro Text Regular",
            size: 18
        )

        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [habitButton, eventButton]
        )

        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16

        return stackView
    }()

    weak var delegate: CreateMainDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc
    private func createHabit() {
        delegate?.createHabit()
    }

    @objc
    private func createEvent() {
        delegate?.createEvent()
    }

    private func makeView() {
        backgroundColor = .ypWhite

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 281
            ),
            stackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -20
            ),
            stackView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -281
            ),
            stackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 20
            )
        ])
    }
}
