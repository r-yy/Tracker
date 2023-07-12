//
//  TabBarController.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    private lazy var trackersVC: TrackersVC = {
        let vc = TrackersVC()
        dateSelectionDelegate = vc
        return vc
    }()
    private let statisticVC = StatisticVC()
    private let datePicker = UIDatePicker()

    weak var dateSelectionDelegate: TabBarControllerDelegate?

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

        let createMainVC = CreateMainVC()
        createMainVC.createMainView.delegate = createMainVC

        navigationController.setViewControllers([createMainVC], animated: true)

        navigationController.modalPresentationStyle = .formSheet
        present(navigationController, animated: true)
    }

    @objc
    private func datePickerTap(_ sender: UIDatePicker) {
        let selectedDate = datePicker.date
        dateSelectionDelegate?.dateSelected(date: selectedDate)
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

        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .ypDateGray
        datePicker.addTarget(self, action: #selector(datePickerTap(_:)), for: .valueChanged)

        let rightBarButton = UIBarButtonItem(customView: datePicker)
        trackersVC.navigationItem.rightBarButtonItem = rightBarButton
    }
}

