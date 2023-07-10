//
//  CreateHabitVC.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class CreateHabitVC: UIViewController {
    lazy var createHabitView: CreateHabitView = {
        let view = CreateHabitView()

        view.tableView.dataSource = self
        view.tableView.delegate = self
        view.collectionView.dataSource = self
        view.collectionView.delegate = self

        return view
    }()

    let gridGeometric = GridGeometric(
        cellCount: 6, leftInset: 16, rightInset: 16, cellSpacing: 16
    )

    var isHabit: Bool

    override func loadView() {
        super.loadView()
        view = createHabitView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setTableHeight()
    }

    init(isHabit: Bool) {
        self.isHabit = isHabit
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Новая привычка"
        titleLabel.textColor = .ypBlack
        titleLabel.font = UIFont(
            name: "SF Pro Text Regular",
            size: 18
        )
        self.navigationItem.titleView = titleLabel
    }

    private func setTableHeight() {
        let height: CGFloat = isHabit ? 150 : 75
        NSLayoutConstraint.activate([
            createHabitView.tableView.heightAnchor.constraint(
                equalToConstant: height
            )
        ])
    }
}

extension CreateHabitVC: CreateHabitDelegate {
    func closeWindow() {
        self.dismiss(animated: true)
    }
}
