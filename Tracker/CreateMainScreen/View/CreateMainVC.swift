//
//  CreateVC.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class CreateMainVC: UIViewController {
    let createMainView = CreateMainView()
    var dataProvider: DataProvider?

    override func loadView() {
        super.loadView()
        view = createMainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
    }

    private func setTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Создание трекера"
        titleLabel.textColor = .ypBlack
        titleLabel.font = UIFont(
            name: "SF Pro Text Regular",
            size: 18
        )
        self.navigationItem.titleView = titleLabel
    }
}

extension CreateMainVC: CreateMainDelegate {
    func createHabit() {
        let createHabitVC = CreateHabitVC(isHabit: true)
        createHabitVC.createHabitView.delegate = createHabitVC
        createHabitVC.dataProvider = dataProvider
        createHabitVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(
            createHabitVC, animated: true
        )
    }

    func createEvent() {
        let createHabitVC = CreateHabitVC(isHabit: false)
        createHabitVC.createHabitView.delegate = createHabitVC
        createHabitVC.dataProvider = dataProvider
        createHabitVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(
            createHabitVC, animated: true
        )
    }
}
