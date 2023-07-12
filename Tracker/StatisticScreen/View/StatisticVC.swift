//
//  StatisticVC.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class StatisticVC: UIViewController {
    private let statisticView = StatisticView()

    override func loadView() {
        super.loadView()
        view = statisticView
    }
}
