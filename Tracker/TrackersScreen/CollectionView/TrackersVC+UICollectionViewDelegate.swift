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
        let indexPath = indexPaths[0]
        let tracker: Tracker = visibleCategories[indexPath.section].trackers[indexPath.row]
            return UIContextMenuConfiguration(actionProvider: { actions in
                return UIMenu(children: [
                    UIAction(
                        title: NSLocalizedString("PIN_LABEL",
                                                 comment: "")
                    ) { _ in
                        self.pinTracker(tracker: tracker)
                    },
                    UIAction(
                        title: NSLocalizedString("EDIT_LABEL",
                                                 comment: "")
                    ) { [weak self] _ in
                        guard let self else { return }
                        let navigationController = UINavigationController()
                        let createHabitVC = CreateHabitVC(
                            isHabit: true,
                            dataProvider: self.dataProvider,
                            trackerToEdit: tracker
                        )
                        createHabitVC.createHabitView.delegate = createHabitVC

                        navigationController.setViewControllers(
                            [createHabitVC], animated: false
                        )

                        navigationController.modalPresentationStyle = .formSheet
                        self.present(navigationController, animated: true)
                    },
                    UIAction(
                        title: NSLocalizedString("DELETE_LABEL",
                                                 comment: ""),
                        attributes: .destructive
                    ) { _ in

                    },
                ])
            })
    }
}
