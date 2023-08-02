//
//  CategoryView.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class CategoriesView: UIView {
    let stubImage: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(named: "mainScreenStub")

        return imageView
    }()

    let stubText: UILabel = {
        let label = UILabel()
        let title = NSLocalizedString("CATEGORIES_STUB_LABEL", comment: "")

        label.text = title
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
        let title = NSLocalizedString("ADD_CATEGORY_BUTTON_TITLE", comment: "")

        button.setTitle(title, for: .normal)
        button.addTarget(
            nil, action: #selector(createCategory), for: .touchUpInside
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

    let tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(
            CategoriesCell.self,
            forCellReuseIdentifier: CategoriesCell.identifier
        )
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .none


        return tableView
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

        addSubview(createButton)
        addSubview(tableView)
        tableView.addSubview(stubImage)
        tableView.addSubview(stubText)

        stubImage.translatesAutoresizingMaskIntoConstraints = false
        stubText.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

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
            ),
            tableView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 24
            ),
            tableView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            tableView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            tableView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -140
            )
        ])
    }
}
