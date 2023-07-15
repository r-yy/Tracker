//
//  TabBarController.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    private let trackersVC = TrackersVC()
    private let statisticVC = StatisticVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeTabBar()
        customizeTabBar()
    }

    private func makeTabBar() {
        let navigationBar = UINavigationController(rootViewController: trackersVC)
        navigationBar.navigationBar.tintColor = .ypBlack

        trackersVC.tabBarItem = UITabBarItem(
            title: "Трекеры", image: UIImage(named: "tracker"), selectedImage: nil
        )

        statisticVC.tabBarItem = UITabBarItem(
            title: "Статистика", image: UIImage(named: "statistic"), selectedImage: nil
        )

        self.viewControllers = [
            navigationBar,
            statisticVC
        ]
    }

    private func customizeTabBar() {
        tabBar.backgroundColor = .ypWhite
        tabBar.barTintColor = .ypBlue
        tabBar.tintColor = .ypBlue
        tabBar.isTranslucent = false
        tabBar.clipsToBounds = true
    }
}

