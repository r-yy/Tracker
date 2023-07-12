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

    let stubImage: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(named: "mainScreenStub")

        return imageView
    }()

    let stubText: UILabel = {
        let label = UILabel()

        label.text = "Что будем отслеживать?"
        label.font = UIFont(
            name: "SF Pro Text Regular",
            size: 12
        )

        return label
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: trackersViewLayout
        )

        collectionView.register(
            TrackersCell.self, forCellWithReuseIdentifier: TrackersCell.identifier
        )
        collectionView.register(
            TrackerHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrackerHeader.identifier
        )
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }()

    let trackersViewLayout = UICollectionViewCompositionalLayout {
        (
            sectionIndex: Int,
            environment: NSCollectionLayoutEnvironment
        ) -> NSCollectionLayoutSection? in

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(167),
            heightDimension: .absolute(148)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 7


        let headerFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(50)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

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
                constant: 20
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
