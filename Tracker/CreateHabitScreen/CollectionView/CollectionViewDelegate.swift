//
//  CollectionViewDelegate.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

extension CreateHabitVC: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return gridGeometric.cellSpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 10,
            left: gridGeometric.leftInset,
            bottom: 10,
            right: gridGeometric.rightInset
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let availableWidth = collectionView.frame.width - gridGeometric.paddingWidth
        let cellWidth =  availableWidth / CGFloat(gridGeometric.cellCount)

        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let cell = collectionView.cellForItem(at: indexPath) as? HabitCollectionViewCell

        if let previousSelectedIndexPath = selectedIndexPaths[indexPath.section],
            let previousSelectedCell = collectionView.cellForItem(
                at: previousSelectedIndexPath
            ) as? HabitCollectionViewCell {
            previousSelectedCell.resetSelectionStyle()
        }

        if indexPath.section == 0 {
            trackerEmoji = emojiArray[indexPath.row]
            cell?.selectCellWithFill()
        } else {
            trackerColor = colorsArray[indexPath.row]
            cell?.selectCellWithOutline(color: colorsArray[indexPath.row])
        }

        selectedIndexPaths[indexPath.section] = indexPath

        UIView.animate(withDuration: 0.15, animations: {
            cell?.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }, completion: { finish in
            UIView.animate(withDuration: 0.15, animations: {
                cell?.transform = CGAffineTransform.identity
            })
        })
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if indexPath.section == 0 {
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: EmojiHeader.identifier,
                    for: indexPath
                ) as? EmojiHeader else {
                    return UICollectionReusableView()
                }
                return header
            } else {
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: ColorsHeader.identifier,
                    for: indexPath
                ) as? ColorsHeader else {
                    return UICollectionReusableView()
                }
                return header
            }
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SpaceFooter.identifier,
                for: indexPath
            ) as? SpaceFooter else {
                return UICollectionReusableView()
            }
            footer.backgroundColor = .clear
            return footer
        default:
            return UICollectionReusableView()
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 30)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.bounds.width, height: 20)
        } else {
            return CGSize(width: collectionView.bounds.width, height: 0)
        }

    }
}
