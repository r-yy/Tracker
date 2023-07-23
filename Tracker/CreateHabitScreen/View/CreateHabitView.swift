//
//  CreateHabitView.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class CreateHabitView: UIView {
    private let cancelButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = .ypWhite
        button.setTitle("Отменить", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(
            nil, action: #selector(cancelButtonTap), for: .touchUpInside
        )
        button.titleLabel?.font = UIFont(
            name: "SF Pro Text Regular",
            size: 16
        )
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.ypRed.cgColor
        button.setTitleColor(.ypRed, for: .normal)

        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [cancelButton, createButton]
        )

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8

        return stackView
    }()

    let textField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(
            frame: CGRect(
                x: 0, y: 0, width: 16, height: textField.frame.height
            )
        )

        textField.backgroundColor = .ypDateGray
        textField.placeholder = "Введите название трекера"
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 16
        textField.becomeFirstResponder()

        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 20))
        textField.rightView = rightView
        textField.rightViewMode = .always

        return textField
    }()

    let clearButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark.circle.fill")?.withTintColor(
            .ypGray, renderingMode: .alwaysOriginal
        )
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20)
        let largeImage = image?.withConfiguration(imageConfig)

        button.setImage(largeImage, for: .normal)
        button.addTarget(
            nil, action: #selector(clearButtonTap), for: .touchUpInside
        )

        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(
            CreateHabitCell.self, forCellReuseIdentifier: CreateHabitCell.identifier
        )
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 16
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none

        return tableView
    }()

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
        )

        collectionView.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: HabitCollectionViewCell.identifier
        )
        collectionView.register(
            EmojiHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: EmojiHeader.identifier
        )
        collectionView.register(
            ColorsHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ColorsHeader.identifier
        )
        collectionView.register(
            SpaceFooter.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: SpaceFooter.identifier
        )
        collectionView.backgroundColor = .ypWhite
        collectionView.showsVerticalScrollIndicator = false
        collectionView.keyboardDismissMode = .onDrag

        return collectionView
    }()

    let createButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = .ypGray
        button.setTitle("Создать", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(
            nil, action: #selector(createButtonTap), for: .touchUpInside
        )
        button.titleLabel?.font = UIFont(
            name: "SF Pro Text Regular",
            size: 16
        )

        return button
    }()

    let warningLabel: UILabel = {
        let label = UILabel()

        label.text = "Ограничение 38 символов"
        label.textColor = .ypRed
        label.font = UIFont(
            name: "SF Pro Text Regular",
            size: 17
        )

        return label
    }()

    var tableViewTopConstraint: NSLayoutConstraint?

    weak var delegate: CreateHabitDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc
    private func cancelButtonTap() {
        delegate?.closeWindow()
    }

    @objc
    private func createButtonTap() {
        delegate?.createTracker()
    }

    @objc private func clearButtonTap() {
        delegate?.clearTextField()
        clearButton.isHidden = true
    }

    private func makeView() {
        backgroundColor = .ypWhite

        [
            textField, tableView, collectionView, stackView, warningLabel, clearButton
        ].forEach { item in
            addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }

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
            tableView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            tableView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            tableView.heightAnchor.constraint(
                equalToConstant: 150
            ),
            collectionView.topAnchor.constraint(
                equalTo: tableView.bottomAnchor,
                constant: 24
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: tableView.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: stackView.topAnchor,
                constant: -16
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: tableView.leadingAnchor
            ),
            stackView.trailingAnchor.constraint(
                equalTo: collectionView.trailingAnchor
            ),
            stackView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            ),
            stackView.leadingAnchor.constraint(
                equalTo: collectionView.leadingAnchor
            ),
            stackView.heightAnchor.constraint(
                equalToConstant: 60
            ),
            warningLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor
            ),
            warningLabel.topAnchor.constraint(
                equalTo: textField.bottomAnchor,
                constant: 8
            ),
            clearButton.centerYAnchor.constraint(
                equalTo: textField.centerYAnchor
            ),
            clearButton.trailingAnchor.constraint(
                equalTo: textField.trailingAnchor,
                constant: -12
            )
        ])
        tableViewTopConstraint = tableView.topAnchor.constraint(
            equalTo: textField.bottomAnchor, constant: 24
        )
        tableViewTopConstraint?.isActive = true
        warningLabel.isHidden = true
        clearButton.isHidden = true
    }
}
