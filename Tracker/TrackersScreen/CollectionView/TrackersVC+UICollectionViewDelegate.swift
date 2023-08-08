//
//  TrackersCollectionViewDelegate.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 11.07.2023.
//

import UIKit

extension TrackersVC: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        visibleCategories.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TrackerHeader.identifier,
                for: indexPath
            ) as? TrackerHeader else {
                return UICollectionReusableView()
            }
            header.setCategoryHeader(
                header: visibleCategories[indexPath.section].title
            )
            return header
        default:
            return UICollectionReusableView()
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemsAt indexPaths: [IndexPath],
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        if indexPaths.count < 1 {
            return nil
        }

        let indexPath = indexPaths[0]
        let tracker: Tracker = visibleCategories[indexPath.section].trackers[indexPath.row]

        let pinAction = tracker.isPinned
        ? UIAction(title: NSLocalizedString("UNPIN_LABEL",
                                            comment: ""), handler: { [weak self] _ in
            self?.unpinTracker(tracker: tracker)
        })
        : UIAction(title: NSLocalizedString("PIN_LABEL",
                                            comment: ""), handler: { [weak self] _ in
            self?.pinTracker(tracker: tracker)
        })

            return UIContextMenuConfiguration(actionProvider: { actions in
                return UIMenu(children: [
                    pinAction,
                    UIAction(
                        title: NSLocalizedString("EDIT_LABEL",
                                                 comment: "")
                    ) { [weak self] _ in
                        self?.openEditorForTracker(tracker: tracker)
                    },
                    UIAction(
                        title: NSLocalizedString("DELETE_LABEL",
                                                 comment: ""),
                        attributes: .destructive
                    ) { [weak self] _ in
                        self?.deleteTracker(tracker: tracker)
                    },
                ])
            })
    }
}
