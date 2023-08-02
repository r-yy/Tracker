//
//  NewCategoryView.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class NewCategoryView: UIView {
    let textField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(
            frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height)
        )
        let title = NSLocalizedString(
            "NEW_CATEGORIES_TEXTFIELD_PLACEHOLDER", comment: ""
        )

        textField.backgroundColor = .ypDateGray
        textField.placeholder = title
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 16
        textField.becomeFirstResponder()

        return textField
    }()

    let createButton: UIButton = {
        let button = UIButton()
        let title = NSLocalizedString("CREATE_CATEGORY_BUTTON_TITLE", comment: "")

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

    weak var delegate: NewCategoryDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc
    private func createCategory() {
        delegate?.saveCategory()
    }

    private func makeView() {
        backgroundColor = .ypWhite

        addSubview(textField)
        addSubview(createButton)
        textField.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 24
            ),
            textField.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            textField.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            textField.heightAnchor.constraint(
                equalToConstant: 75
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

