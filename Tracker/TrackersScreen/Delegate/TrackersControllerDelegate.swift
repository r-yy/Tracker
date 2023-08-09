//
//  TrackersControllerDelegate.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 12.07.2023.
//

import Foundation

protocol TrackersControllerDelegate: AnyObject {
    func plusButtonTap(cell: TrackersCell)
}

protocol TrackersViewDelegate: AnyObject {
    func openFilters()
}
