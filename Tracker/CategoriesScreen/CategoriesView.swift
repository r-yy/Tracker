//
//  CategoryView.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class CategoriesView: UIView {
    private let stubImage: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(named: "mainScreenStub")

        return imageView
    }()

    private let stubText: UILabel = {
        let label = UILabel()

        label.text = "Привычки и события можно\nобъединить по смыслу"
        label.font = UIFont(
            name: "SF Pro Text Regular",
            size: 12
        )
        label.numberOfLines = 2
        label.textAlignment = .center

        return label
    }()

    let createButton: UIButton = {
        let button = UIButton()

        button.setTitle("Добавить категорию", for: .normal)
        button.addTarget(
            self, action: #selector(createCategory), for: .touchUpInside
        )
        button.titleLabel?.font = UIFont(
            name: "SF Pro Text Regular",
            size: 16
        )
        button.backgroundColor = .ypBlack
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16

        return button
    }()

    weak var delegate: CategoriesDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc
    private func createCategory() {
        delegate?.createCategory()
    }

    private func makeView() {
        backgroundColor = .ypWhite

        addSubview(stubImage)
        addSubview(stubText)
        addSubview(createButton)

        stubImage.translatesAutoresizingMaskIntoConstraints = false
        stubText.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stubImage.centerYAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerYAnchor
            ),
            stubImage.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor
            ),
            stubText.topAnchor.constraint(
                equalTo: stubImage.bottomAnchor,
                constant: 10
            ),
            stubText.centerXAnchor.constraint(
                equalTo: stubImage.centerXAnchor
            ),
            createButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -20
            ),
            createButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            ),
            createButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 20
            ),
            createButton.heightAnchor.constraint(
                equalToConstant: 60
            )
        ])
    }
}
