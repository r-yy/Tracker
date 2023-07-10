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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizeTabBar()
        setNavigationBar()
    }

    @objc
    private func leftButtonTap() {
        let navigationController = UINavigationController()
        navigationController.title = "HUI"
        navigationController.navigationItem.titleView
        navigationController.navigationItem.titleView?.tintColor = .ypBlack
        let createMainVC = CreateMainVC()
        createMainVC.createMainView.delegate = createMainVC

        navigationController.setViewControllers([createMainVC], animated: true)

        navigationController.modalPresentationStyle = .formSheet
        present(navigationController, animated: true)
    }

    @objc
    private func datePickerTap(_ sender: UIDatePicker) {

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

    private func setNavigationBar() {
        let image = UIImage(systemName: "plus")
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 21, weight: .semibold)
        let largeImage = image?.withConfiguration(imageConfig)

        let leftBarButton = UIBarButtonItem(
            image: largeImage,
            style: .plain,
            target: self,
            action: #selector(leftButtonTap)
        )
        trackersVC.navigationItem.leftBarButtonItem = leftBarButton

        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .ypDateGray
        datePicker.addTarget(self, action: #selector(datePickerTap(_:)), for: .touchUpInside)

        let rightBarButton = UIBarButtonItem(customView: datePicker)
        trackersVC.navigationItem.rightBarButtonItem = rightBarButton
    }
}

