//
//  TrackersView.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class TrackersView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()

        label.text = "Трекеры"
        label.font = UIFont(
            name: "SF Pro Text Bold",
            size: 34
        )
        label.textColor = .ypBlack

        return label
    }()

    let searchView: UISearchTextField = {
        let searchView = UISearchTextField()

        searchView.backgroundColor = .ypDateGray
        searchView.placeholder = "Поиск"

        return searchView
    }()

    private let stubImage: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(named: "mainScreenStub")

        return imageView
    }()

    private let stubText: UILabel = {
        let label = UILabel()

        label.text = "Что будем отслеживать?"
        label.font = UIFont(
            name: "SF Pro Text Regular",
            size: 12
        )

        return label
    }()

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: UICollectionViewLayout()
        )

//        collectionView.backgroundColor = .ypBlue

        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func makeView() {
        backgroundColor = .ypWhite
        addSubview(titleLabel)
        addSubview(searchView)
        addSubview(collectionView)
        collectionView.addSubview(stubImage)
        collectionView.addSubview(stubText)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        searchView.translatesAutoresizingMaskIntoConstraints = false
        stubImage.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        stubText.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            searchView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 10
            ),
            searchView.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),
            searchView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            searchView.heightAnchor.constraint(
                equalToConstant: 36
            ),
            stubImage.centerYAnchor.constraint(
                equalTo: collectionView.centerYAnchor
            ),
            stubImage.centerXAnchor.constraint(
                equalTo: collectionView.centerXAnchor
            ),
            collectionView.topAnchor.constraint(
                equalTo: searchView.bottomAnchor,
                constant: 10
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: searchView.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -10
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: searchView.leadingAnchor
            ),
            stubText.topAnchor.constraint(
                equalTo: stubImage.bottomAnchor,
                constant: 10
            ),
            stubText.centerXAnchor.constraint(
                equalTo: stubImage.centerXAnchor
            )
        ])
    }
}
