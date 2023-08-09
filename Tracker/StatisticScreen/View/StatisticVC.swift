//
//  StatisticVC.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class StatisticVC: UIViewController {
    private let statisticView = StatisticView()
    private let dataProvider = DataProvider()

    override func loadView() {
        super.loadView()
        view = statisticView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkEmptyState()
    }

    private func checkEmptyState() {
        let currentTrackers = dataProvider.getTrackers()
        if currentTrackers.isEmpty {
            statisticView.isNeedHideStubs(false)
        } else {
            statisticView.isNeedHideStubs(true)
        }
    }
}

extension StatisticVC: StatisticDelegate {
    func updateTrackersCompletedRecord(count: Int) {
        let stringCount = String(count)
        statisticView.setCompletedTrackersCounter(count: stringCount)
    }
}
