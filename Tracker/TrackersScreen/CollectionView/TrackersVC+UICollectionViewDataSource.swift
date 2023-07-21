//
//  CollectionViewDataSource.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 11.07.2023.
//

import UIKit

extension TrackersVC: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if section < visibleCategories.count {
            return visibleCategories[section].trackers.count
        } else {
            return 0
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackersCell.identifier, for: indexPath
        ) as? TrackersCell else {
            return UICollectionViewCell()
        }

        let isTrackerCompleted = completedTrackers.contains(where: { (tracker) -> Bool in
            let selectedDateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
            let selectedDateOnly = calendar.date(from: selectedDateComponents)

            let recordDateComponents = calendar.dateComponents([.year, .month, .day], from: tracker.date)
            let recordDateOnly = calendar.date(from: recordDateComponents)
            return tracker.id == visibleCategories[indexPath.section].trackers[indexPath.row].id && recordDateOnly == selectedDateOnly
        })


        cell.configCell(
            backgroundColor: visibleCategories[indexPath.section].trackers[indexPath.row].color,
            emojilabel: visibleCategories[indexPath.section].trackers[indexPath.row].emoji,
            titleLabel: visibleCategories[indexPath.section].trackers[indexPath.row].title,
            dayCounter: visibleCategories[indexPath.section].trackers[indexPath.row].dayCounter,
            isTrackerCompleted: isTrackerCompleted
        )
        cell.delegate = self

        return cell
    }


}
