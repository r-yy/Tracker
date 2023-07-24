//
//  CreateVC.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class CreateMainVC: UIViewController {
    let createMainView = CreateMainView()
    var dataProvider: DataProviderProtocol

    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

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
        let createHabitVC = CreateHabitVC(isHabit: true, dataProvider: dataProvider)
        createHabitVC.createHabitView.delegate = createHabitVC
        createHabitVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(
            createHabitVC, animated: true
        )
    }

    func createEvent() {
        let createHabitVC = CreateHabitVC(isHabit: false, dataProvider: dataProvider)
        createHabitVC.createHabitView.delegate = createHabitVC
        createHabitVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(
            createHabitVC, animated: true
        )
    }
}
