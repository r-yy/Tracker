//
//  CollectionViewDataSource.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

extension CreateHabitVC: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 18
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath
            ) as? HabitCollectionViewCell else {
            return UICollectionViewCell()
        }

        if indexPath.section == 0 {
            cell.configEmojiCell(emoji: emojiArray[indexPath.row])
        } else {
            cell.configColorCell(color: colorsArray[indexPath.row])
        }

        return cell
    }
}
